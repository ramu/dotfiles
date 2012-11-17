"---------------
" 06_program.vim
"---------------
" tab/indent
set ts=4 sw=3
set softtabstop=3
set expandtab
set autoindent
set smartindent
set cindent

" <C-]>でタグジャンプ時にタグが複数あったらリスト表示、カーソルがウィンドウの中心になるようにジャンプ
nnoremap <C-]> g<C-]>zz
" タグファイルはカレントファイルのパスを基準に上向き検索
set tags=./tags;
" grepは再帰検索、行番号表示あり、倍なりファイルは対象外、マッチ行にファイル名表示
set grepprg=grep\ -rnIH\ --exclude-dir=.hg\ --exclude=tags
" (l以外で始まる)QuickFixコマンドの実行が終わったらQuickFixウィンドウを開く
autocmd QuickfixCmdPost [^l]* copen

