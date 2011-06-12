;;; 10_php-mode.el --- 
(require 'php-mode)

(eval-after-load 'php-mode
  '(progn
    ;; C-c RET: php-browse-manual
    (setq php-manual-url "http://www.php.net/manual/ja/")
    ;; C-c C-f: php-search-documentation
    (setq php-search-url "http://jp2.php.net/")
    ;; 補完のためのマニュアルのパス
    (setq php-manual-path "~/.emacs.d/info/")
    ;; M-TAB が有効にならないので以下の設定を追加
    (define-key php-mode-map "\C-\M-i" 'php-complete-function)
    ;; その他
    (define-key php-mode-map "\C-\M-a" 'php-beginning-of-defun)
    (define-key php-mode-map "\C-\M-e" 'php-end-of-defun)
    ))

