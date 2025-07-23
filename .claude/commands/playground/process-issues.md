# GitHub issue batch processor for Claude Code
# Usage: ./process-issues.sh <label> [options]
# Example: ./process-issues.sh bug-fix 15

set -e

# デフォルト値
BATCH_SIZE=10
DRY_RUN=false
VERBOSE=false
LOG_FILE=""
CONTINUE_ON_ERROR=false

# 使用方法を表示
show_usage() {
    cat << EOF
Usage: $0 <label> [options]

Options:
    -b, --batch-size SIZE  Batch size (default: 10)
    -m, --max-issues NUM   Maximum number of issues to process (default: all)
    -d, --dry-run          Show what would be processed without executing
    -v, --verbose          Verbose output
    -l, --log-file FILE    Log output to file
    -c, --continue         Continue processing on errors
    -h, --help             Show this help

Examples:
    $0 claude-enhancement                           # Process all issues
    $0 bug-fix --batch-size 15 --dry-run          # Dry run with batch size 15
    $0 feature-request --max-issues 50             # Process max 50 issues
    $0 🤖ai-assist 10                              # Process max 10 issues (legacy format)
EOF
}

# 引数解析
LABEL=""
MAX_ISSUES=""  # 最大処理件数（空の場合は全件処理）
while [[ $# -gt 0 ]]; do
    case $1 in
        -b|--batch-size)
            BATCH_SIZE="$2"
            shift 2
            ;;
        -m|--max-issues)
            MAX_ISSUES="$2"
            shift 2
            ;;
        -d|--dry-run)
            DRY_RUN=true
            shift
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        -l|--log-file)
            LOG_FILE="$2"
            shift 2
            ;;
        -c|--continue)
            CONTINUE_ON_ERROR=true
            shift
            ;;
        -h|--help)
            show_usage
            exit 0
            ;;
        -*)
            echo "Unknown option: $1"
            show_usage
            exit 1
            ;;
        *)
            if [ -z "$LABEL" ]; then
                LABEL="$1"
            elif [ -z "$MAX_ISSUES" ] && [[ "$1" =~ ^[0-9]+$ ]]; then
                # 数字の場合は最大処理件数として扱う（後方互換性）
                MAX_ISSUES="$1"
            else
                echo "Error: Unexpected argument '$1'"
                echo "Use --max-issues for numeric limits or check your label"
                show_usage
                exit 1
            fi
            shift
            ;;
    esac
done

# 必須引数チェック
if [ -z "$LABEL" ]; then
    echo "Error: Label is required"
    show_usage
    exit 1
fi

# ログ関数
log() {
    local message="[$(date '+%Y-%m-%d %H:%M:%S')] $1"
    echo "$message"
    if [ -n "$LOG_FILE" ]; then
        echo "$message" >> "$LOG_FILE"
    fi
}

verbose_log() {
    if [ "$VERBOSE" = true ]; then
        log "$1"
    fi
}

# GitHub CLI存在確認
if ! command -v gh &> /dev/null; then
    log "Error: GitHub CLI (gh) is not installed"
    exit 1
fi

# 認証確認
if ! gh auth status &> /dev/null; then
    log "Error: Not authenticated with GitHub CLI"
    log "Please run: gh auth login"
    exit 1
fi

log "Processing issues with label: $LABEL"
log "Batch size: $BATCH_SIZE"
if [ -n "$MAX_ISSUES" ]; then
    log "Max issues: $MAX_ISSUES"
else
    log "Max issues: all"
fi
log "Dry run: $DRY_RUN"

# issue番号と詳細情報を取得
verbose_log "Fetching issue numbers and details..."
issues=()
issue_details=()
while IFS=$'\t' read -r number title body; do
    issues+=("$number")
    issue_details+=("$number|$title|$body")
done < <(gh issue list --label "$LABEL" --json number,title,body --jq '.[] | [.number, .title, .body] | @tsv' | sort -n)

if [ ${#issues[@]} -eq 0 ]; then
    # エラーチェック：GitHub API呼び出しが失敗した場合
    if ! gh issue list --label "$LABEL" --json number &> /dev/null; then
        log "Error: Failed to fetch issues from GitHub"
        exit 1
    fi
fi

if [ ${#issues[@]} -eq 0 ]; then
    log "No issues found with label: $LABEL"
    exit 1
fi

# 最大処理件数の制限を適用
if [ -n "$MAX_ISSUES" ] && [ "$MAX_ISSUES" -lt ${#issues[@]} ]; then
    issues=("${issues[@]:0:$MAX_ISSUES}")
    issue_details=("${issue_details[@]:0:$MAX_ISSUES}")
    log "Limited to first $MAX_ISSUES issues out of total found"
fi

log "Found ${#issues[@]} issues to process"


# バッチに分割
total_batches=$(((${#issues[@]} + BATCH_SIZE - 1) / BATCH_SIZE))
log "Will process in $total_batches batches of up to $BATCH_SIZE issues each"

if [ "$DRY_RUN" = true ]; then
    log "DRY RUN - No actual processing will occur"
    
    for ((i=0; i<${#issues[@]}; i+=BATCH_SIZE)); do
        batch=("${issues[@]:i:BATCH_SIZE}")
        batch_num=$((i/BATCH_SIZE + 1))
        
        echo ""
        echo "=== Batch $batch_num/$total_batches ==="
        echo "Issues: ${batch[*]}"
        
        if [ "$VERBOSE" = true ]; then
            for ((j=0; j<${#batch[@]}; j++)); do
                issue_num="${batch[j]}"
                detail_index=$((i+j))
                if [ $detail_index -lt ${#issue_details[@]} ]; then
                    IFS='|' read -r num title body <<< "${issue_details[$detail_index]}"
                    echo "  #$num: $title"
                    echo "    Body: $body"
                fi
            done
        fi
    done
    
    log "DRY RUN completed"
    exit 0
fi

# 並列処理用関数
process_batch_parallel() {
    local batch=("$@")
    local pids=()
    
    for issue_num in "${batch[@]}"; do
        (
            # 各issueの詳細を取得
            detail=$(gh issue view "$issue_num" --json title,body --jq '.title + "|" + .body')
            IFS='|' read -r title body <<< "$detail"
            
            # 個別のClaude Code実行
            claude -p "GitHub issue #$issue_num を処理してください。

Title: $title
Body: $body

issue の内容を正確に確認し、指示に従って適切に処理してください。
処理完了後、issue をクローズしてください。"
        ) &
        pids+=($!)
    done
    
    # 全てのプロセスの完了を待つ
    for pid in "${pids[@]}"; do
        wait $pid
    done
}

# 実際の処理（自動継続、並列処理）
for ((i=0; i<${#issues[@]}; i+=BATCH_SIZE)); do
    batch=("${issues[@]:i:BATCH_SIZE}")
    batch_num=$((i/BATCH_SIZE + 1))
    
    log ""
    log "=== Processing Batch $batch_num/$total_batches ==="
    log "Issues: ${batch[*]}"
    
    verbose_log "Processing batch in parallel mode..."
    
    if [ "$CONTINUE_ON_ERROR" = true ]; then
        if ! process_batch_parallel "${batch[@]}"; then
            log "Warning: Batch $batch_num failed, continuing to next batch"
            continue
        fi
    else
        process_batch_parallel "${batch[@]}"
    fi
    
    log "Batch $batch_num completed successfully"
done

log "All batches completed successfully!"
