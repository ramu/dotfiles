;;;; 50_html.el
(require '00_common)

;;; default browser
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "open")

;;; emmet-mode.el
(my-require-and-when 'emmet-mode
  (add-hook 'sgml-mode-hook 'emmet-mode)
  (add-hook 'css-mode-hook 'emmet-mode)
  ;(add-hook 'html-mode-hook 'emmet-mode)
  ;(add-hook 'xml-mode-hook  'emmet-mode)
  (add-hook 'php-mode-hook 'emmet-mode)
  (add-hook 'emmet-mode-hook (lambda ()
                               (setq emmet-indentation 2)
                               (setq emmet-move-cursor-between-quotes t)))
  (define-key emmet-mode-keymap (kbd "C-j") nil)
  (define-key emmet-mode-keymap (kbd "C-c C-m") 'emmet-expand-line)
  (define-key emmet-preview-keymap (kbd "C-c C-m") 'emmet-preview-accept))

;;; less-css-mode
(my-require-and-when 'less-css-mode)

;;; Warp
(my-require-and-when 'warp
  (add-hook 'html-mode-hook 'warp-mode)
  (my-require-and-when 'warp-reload))

;;; scss-mode(http://d.hatena.ne.jp/CortYuming/20120110/p1)
(defun my-css-electric-pair-brace ()
  (interactive)
  (insert "{")
  (newline-and-indent)
  (newline-and-indent)
  (insert "}")
  (indent-for-tab-command)
  (previous-line)
  (indent-for-tab-command))

(defun my-semicolon-ret ()
  (interactive)
  (insert ";")
  (newline-and-indent))

(my-require-and-when 'scss-mode
  (add-to-list 'auto-mode-alist '("\\.\\(scss\\|css\\)\\'" . scss-mode))
  (add-hook 'scss-mode-hook 'ac-css-mode-setup)
  (add-hook 'scss-mode-hook
            (lambda ()
              (define-key scss-mode-map "\M-{" 'my-css-electric-pair-brace)
              (define-key scss-mode-map ";" 'my-semicolon-ret)
              (setq css-indent-offset 2)
              (setq scss-compile-at-save nil)
              (setq ac-sources '(ac-source-yasnippet
                                 ac-source-words-in-all-buffer
                                 ac-source-dictionary))
              (flymake-mode t)))
  (add-to-list 'ac-modes 'scss-mode))

