;; 09_util.el
; ps-print-buffer
(setq ps-multibyte-buffer 'non-latin-printer)

; hippie-expand
(global-set-key "\C-^" 'hippie-expand)
(setq hippie-expand-try-functions-list
      '(yas/hippie-try-expand
        try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-file-name-partially
        try-complete-file-name
        try-expand-all-abbrevs
        try-expand-list try-expand-line
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol))

; shell
(defun skt:shell ()
  (or (executable-find "zsh")
      (executable-find "bash")
      (executable-find "cmdproxy")
      (error "can't find 'shell' command in PATH")))
(setq shell-file-name (skt:shell))
(setenv "SHELL" shell-file-name)
(setq explicit-shell-file-name shell-file-name)

; scratch
(setq initial-scratch-message nil)

; 自動再読み込み
(global-auto-revert-mode)

; 折り返し
(setq-default truncate-partial-width-windows t)
(setq-default truncate-lines t)

; completionsのhelp不要
(setq completion-show-help nil)

; 保存時に実行権限付加
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

; ホイールマウス使用
(mouse-wheel-mode t)

; カーソルのある行/列番号表示
(setq line-number-mode t)
(setq column-number-mode t)

; カーソル点滅
(blink-cursor-mode t)
(setq blink-cursor-interval 0.7)

; スクロールバーを消す
(setq scroll-bar-mode nil)
; スクロールバーを右に表示
;(set-scroll-bar-mode 'right)

; 時計表示
(setq display-time-24hr-format t)
(setq display-time-string-forms '(24-hours ":" minutes))
(display-time)

; 画像表示
(auto-image-file-mode t)

; kill-ringの最大値
(setq kill-ring-max 100)

;; バックアップに関する設定
(setq make-backup-files nil)  ; バックアップファイルを作成しない
(setq auto-save-default nil)  ; #filename#を作成しない

; 警告音を消す
(setq visible-bell t)

; カーソルが行頭にある場合も行全体削除
(setq kill-whole-line t)

; タブインデント禁止
(setq-default indent-tabs-mode nil)
(setq indent-tabs-mode nil)

; 現在位置(カーソル）のファイル、URLを開く
(ffap-bindings)

; 開始時に表示されるメッセージを非表示
(setq inhibit-startup-message t)

; ツールバー非表示
(tool-bar-mode -1)

; 対応する括弧を光らせる(グラフィック環境のみ)
(show-paren-mode t)
(setq show-paren-style 'expression)
(set-face-background 'show-paren-match-face "#222277")
;(set-face-underline-p 'show-paren-match-face "lightblue")

; 行末の空白表示
(setq-default show-trailing-whitespace t)

; region high-light
(setq transient-mark-mode t)

; region color
(set-face-background 'region "darkgreen")

; .emacsファイルを開くショートカット
(global-set-key [(f7)] '(lambda ()(interactive)(find-file "~/.emacs")))

; flyspell-mode(スペルチェッカ)
(setq flyspell-mode t)

; find-fileで大文字小文字を区別しない
(setq read-file-name-completion-ignore-case t)

; 画面外への移動のスクロールを１にする
;(setq scroll-conservatively 1)
;(setq comint-scroll-show-maximum-output t)
(setq scroll-conservatively 35
      scroll-margin 0
      scroll-step 1)

; ミニバッファを再帰的に呼び出す
(setq enable-recursive-minibuffers t)

; キーストロークをエコーエリアに表示する速度を早く
(setq echo-keystrokes 0.1)

; yes入力するの面倒 → yでok
(defalias 'yes-or-no-p 'y-or-n-p)

; ファイル名がかぶった場合にディレクトリ名を表示
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-ignore-buffers-re "*[^*]+*")

; バッファきりかえ強化
;(iswitchb-mode t)
;(setq read-buffer-function 'iswitchb-read-buffer)
;(setq iswitchb-regexp t)
;(setq iswitchb-prompt-newbuffer nil)

; 矩形を選択しやすくする
(require 'cua-mode nil t)
(cua-mode t)
; これをいれないとC-c C-v辺りを乗っ取られる
(setq cua-enable-cua-keys nil)

;;; view-mode関連(Emacs technic bible参考)
;; read-only fileはview-modeで開く
(setq view-read-only t)
;; 書き込み不能ファイルの場合はview-modeを抜けない
;(require 'viewer)
;(viewer-stay-in-setup)
;; kj同時押しでview-modeきりかえ
;(require 'key-chord)
;(setq key-chord-two-keys-delay 0.04)
;(key-chord-define-global "kj" 'view-mode)
;; view-modeの場合はmode-lineに色をつける
;(setq viewer-modeline-color-unwritable "tomato")
;(setq viewer-modeline-color-view "orange")
;(viewer-change-modeline-color-setup)
;; 特定のファイルは必ずview-modeで開く
;(setq view-mode-by-default-regexp "¥¥.log$")

;;; 現在の関数名を常に表示する
(require 'which-func)
(which-func-mode 1)
; すべてのメジャーモードに対してwhich-func-modeを適用する
(setq which-func-modes t)

; 終了時にプロセス確認しない
(defadvice save-buffers-kill-terminal (before my-save-buffers-kill-terminal activate)
  (when (process-list)
    (dolist (p (process-list))
      (set-process-query-on-exit-flag p nil))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 以下、ちょっと長い設定/function
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ,と.をbufferの切り替えに利用する
(defvar my-ignore-blst
  '("*Help*" "*Compile-Log*"))
(defvar my-visible-blst nil)
(defvar my-bslen 15)
(defvar my-blist-display-time 2)
(defface my-cbface
  '((t (:foreground "wheat" :underline t))) nil :group 'my-cbfaces)

(defun my-visible-buffers (blst)
  (if (eq blst nil) '()
    (let ((bufn (buffer-name (car blst))))
      (if (or (= (aref bufn 0) ? ) (member bufn my-ignore-blst))
          (my-visible-buffers (cdr blst))
        (cons (car blst) (my-visible-buffers (cdr blst)))))))

(defun my-show-buffer-list (prompt spliter)
  (let* ((len (string-width prompt))
         (str (mapconcat
                (lambda (buf)
                  (let ((bs (copy-sequence (buffer-name buf))))
                    (when (> (string-width bs) my-bslen)
                      (setq bs (concat (substring bs 0 (- my-bslen 2)) "..")))
                    (setq len (+ len (string-width (concat bs spliter))))
                    (when (eq buf (current-buffer))
                      (put-text-property 0 (length bs) 'face 'my-cbface bs))
                    (cond ((>= len (frame-width))
                           (setq len (+ (string-width (concat prompt bs spliter))))
                           (concat "\n" (make-string (string-width prompt) ? ) bs))
                          (t bs))))
               my-visible-blst spliter)))
    (let (message-log-max)
      (message "%s" (concat prompt str))
      (when (sit-for my-blist-display-time) (message nil)))))

(defun my-operate-buffer (pos)
  (unless (window-minibuffer-p (selected-window))
    (unless (eq last-command 'my-operate-buffer)
      (setq my-visible-blst (my-visible-buffers (buffer-list))))
    (let* ((blst (if pos my-visible-blst (reverse my-visible-blst))))
      (switch-to-buffer (or (cadr (memq (current-buffer) blst)) (car blst))))
    (my-show-buffer-list (if pos "[-->] " "[<--] ") (if pos " > " " < " )))
  (setq this-command 'my-operate-buffer))

(global-set-key [?\C-,] (lambda () (interactive) (my-operate-buffer nil)))
(global-set-key [?\C-.] (lambda () (interactive) (my-operate-buffer t)))



;; flyspell + popup
;; (defun flyspell-correct-word-popup-el ()
;;     "Pop up a menu of possible corrections for misspelled word before point."
;;     (interactive)
;;     ;; use the correctdictionary
;;     (flyspell-accept-buffer-local-defs)
;;     (let ((cursor-location (point))
;;         (word (flyspell-get-word nil)))
;;      (if (consp word)
;;        (let ((start (car (cdr word)))
;;             (end (car (cdr (cdr word))))
;;             (word (car word))
;;             poss ispell-filter)
;;          ;; now check spelling of word.
;;          (ispell-send-string "%\n")
;;          (ispell-send-string (concat "^" word "\n"))
;;          ;; wait until ispell has processed word
;;          (while (progn
;;                   (accept-process-output ispell-process)
;;                   (not (string= "" (car ispell-filter)))))
;;          ;; Remove leading empty element
;;          (setq ispell-filter (cdr ispell-filter))
;;          ;; ispell process should return something after word is sent.
;;          ;; Tag word as valid (i.e., skip) otherwise
;;          (or ispell-filter
;;              (setq ispell-filter '(*)))
;;          (if (consp ispell-filter)
;;              (setq poss (ispell-parse-output (car ispell-filter))))
;;          (cond
;;              ((or (eq poss t) (stringp poss))
;;                  ;; don't correct word
;;                  t)
;;              ((null poss)
;;                  ;; ispell error
;;                  (error "Ispell: error in Ispell process"))
;;                      (t
;;                      ;; The word is incorrect, we have to propose a replacement.
;;                         (flyspell-do-correct (popup-menu* (car (cddr poss)) :scroll-bar t :margin t)
;;                                 poss word cursor-location start end cursor-location)))
;;                         (ispell-pdict-save t)))))
;; 修正したい単語の上にカーソルをもっていき、C-M-returnで候補を選択
;; (add-hook 'flyspell-mode-hook
;;     (lambda ()
;;         (define-key flyspell-mode-map (kbd "<C-M-return>") 'flyspell-correct-word-popup-el)
;;     ))


;; bookmark.el
; bookmarkを変更したら即保存
;; (require 'bookmark)
;; (setq bookmark-save-flag 1)
;; ; 整理(最近使ったbookmarkを最上部へ)
;; (Progn
;;     (setq bookmark-sort-flag nil)
;;     (defun bookmark-arrange-latest-top ()
;;         (let ((latest (bookmark-get-bookmark bookmark)))
;;             (setq bookmark-alist (cons latest (delq latest bookmark-alist))))
;;         (bookmark-save))
;;     (add-hook 'bookmark-after-jump-hook 'bookmark-arrange-latest-top))

;; tail
(defun my-auto-revert-tail-mode-on ()
  (interactive)
  (when (string-match "^/var/log/" default-directory)
    (auto-revert-tail-mode t)))
(add-hook 'find-file-hook 'my-auto-revert-tail-mode-on)
(add-hook 'after-revert-hook
          (lambda ()
            (when auto-revert-tail-mode
              (end-of-buffer))))

;; topcoder
(defun topcoder-setup ()
  (interactive)
  (setq truncate-partial-width-windows nil)
  (setq truncate-lines nil)
  (display-buffer-other-frame "*Messages*"))

;; Clipboardを共有(Mac)
;(defun copy-from-osx ()
;  (shell-command-to-string "pbpaste"))
;(defun paste-to-osx (text &optional push)
;  (let ((process-connection-type nil))
;    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
;      (process-send-string proc text)
;      (process-send-eof proc))))
;(setq interprogram-cut-function 'paste-to-osx)
;(setq interprogram-paste-function 'copy-from-osx)

;;; scratchを削除しない
(defun my-make-scratch (&optional arg)
  (interactive)
  (progn
    ;; "*scratch*" を作成して buffer-list に放り込む
    (set-buffer (get-buffer-create "*scratch*"))
    (funcall initial-major-mode)
    (erase-buffer)
    (when (and initial-scratch-message (not inhibit-startup-message))
      (insert initial-scratch-message))
    (or arg (progn (setq arg 0)
                   (switch-to-buffer "*scratch*")))
    (cond ((= arg 0) (message "*scratch* is cleared up."))
          ((= arg 1) (message "another *scratch* is created")))))

(defun my-buffer-name-list ()
  (mapcar (function buffer-name) (buffer-list)))

(add-hook 'kill-buffer-query-functions
    ;; *scratch* バッファで kill-buffer したら内容を消去するだけにする
          (function (lambda ()
                      (if (string= "*scratch*" (buffer-name))
                          (progn (my-make-scratch 0) nil)
                        t))))

(add-hook 'after-save-hook
;; *scratch* バッファの内容を保存したら *scratch* バッファを新しく作る
          (function (lambda ()
                      (unless (member "*scratch*" (my-buffer-name-list))
                        (my-make-scratch 1)))))
