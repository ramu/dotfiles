;;; 10_bf-mode.el --- 
(require 'bf-mode)

;; 別ウィンドウに表示するサイズの上限
(setq bf-mode-browsing-size 10)

;; 別ウィンドウに表示しないファイルの拡張子
(setq bf-mode-except-ext '("\\.exe$" "\\.com$"))

;; 容量がいくつであっても表示して欲しいもの
(setq bf-mode-force-browse-exts
      (append '("\\.texi$" "\\.el$")
              bf-mode-force-browse-exts))

;; html は w3m で表示する
(setq bf-mode-html-with-w3m t)

;; 圧縮されたファイルを表示
(setq bf-mode-archive-list-verbose t)

;; ディレクトリ内のファイル一覧を表示
(setq bf-mode-directory-list-verbose t)

;(add-hook 'dired-ex-finish-hook 'df-mode)
