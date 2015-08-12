;;; 50_php.el ---
(require '00_common)

;;; php-mode
(my-require-and-when 'php-mode
  (eval-after-load 'php-mode
    '(progn
      ;; C-c RET: php-browse-manual
      (setq php-manual-url "http://www.php.net/manual/ja/")
      ;; C-c C-f: php-search-documentation
      (setq php-search-url "http://jp2.php.net/")
      ;; 補完のためのマニュアルのパス
      (setq php-manual-path "~/.emacs.d/share/info/")
      ;; M-TAB が有効にならないので以下の設定を追加
      (define-key php-mode-map "\C-\M-i" 'php-complete-function)
      ;; その他
      (define-key php-mode-map "\C-\M-a" 'php-beginning-of-defun)
      (define-key php-mode-map "\C-\M-e" 'php-end-of-defun)
      ))
  (add-auto-mode 'php-mode "\\.ctp$")

  ;;; phpdoc
  (my-require-and-when 'phpdoc
    (add-hook 'php-mode-hook (lambda () (eldoc-mode t)))))

(defun php-indent-hook ()
  (setq indent-tabs-mode nil)
  (setq c-basic-offset 2)
  (c-set-offset 'arglist-intro '+)
  (c-set-offset 'arglist-close 0))

(add-hook 'php-mode-hook 'php-indent-hook)

; mmm-mode in php
(my-require-and-when 'mmm-mode
  (setq mmm-global-mode 'maybe)
  (mmm-add-mode-ext-class nil "\\.php?\\'" 'html-php)
  (mmm-add-classes '((html-php
                      :submode php-mode
                      :front "<\\?\\(php\\)?"
                      :back "\\?>")))
  (add-auto-mode 'xml-mode "\\.php?\\'"))
