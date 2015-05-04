;;;; 10_dired.el ---
(require '00_common)

;;; dired
(my-require-and-when 'dired
  (setq dired-dwim-target t)            ; dired2つ開いてるときに、move/copy先をもう一方のdiredで開いてる場所にする
  (setq dired-recursive-copies 'always)

  (define-key dired-mode-map (kbd "C-x C-f") 'helm-find-files)

  ;(defvar diredp-file-name 'diredp-file-name)
  (set-face-foreground 'diredp-file-name "#FFFFFF")
  (set-face-foreground 'diredp-file-suffix "#FFFFFF")

  ;(set-face-foreground 'diredp-dir-priv "#FFFFFF")
  (set-face-foreground 'diredp-dir-priv "#009900")
  (set-face-background 'diredp-dir-priv "#000000")
  (set-face-foreground 'diredp-number "#DDAA33"))

;;; diredでファイル名変更できる - wdired.el
(my-require-and-when 'dired+
  (define-key dired-mode-map "r" 'wdired-change-to-wdired-mode))

;;; dired-ex-isearch.el
; EmacsのdiredでExplorer のようにファイル名の 1 文字目で検索する(改)
; http://filmlang.org/soft/emacs/dired-ex-isearch
(my-require-and-when 'dired-ex-isearch
  (define-key dired-mode-map "/" 'dired-ex-isearch))

;;; bf-mode.el
; diredでファイル内容表示など
(my-require-and-when 'bf-mode
  (setq bf-mode-browsing-size 10)                   ; 別ウィンドウに表示するサイズの上限
  (setq bf-mode-except-exts '("\\.exe$" "\\.com$")) ; 別ウィンドウに表示しないファイルの拡張子
  (setq bf-mode-html-with-w3m t)                    ; html は w3m で表示する
  (setq bf-mode-archive-list-verbose t)             ; 圧縮されたファイルを表示
  (setq bf-mode-directory-list-verbose t)           ; ディレクトリ内のファイル一覧を表示
  (setq bf-mode-enable-at-starting-dired t)         ; dired起動時にbf-mode起動
  (setq bf-mode-directly-quit t)                    ; dired終了時にbf-mode終了
  ; 容量がいくつであっても表示して欲しいもの
  (setq bf-mode-force-browse-exts (append '("\\.texi$" "\\.el$") bf-mode-force-browse-exts)))
