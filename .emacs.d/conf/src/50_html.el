;;;; 50_html.el
(require '00_common)

;;; default browser
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "open")

;;; zencoding-mode.el
(my-require-and-when 'zencoding-mode
  (add-hook 'sgml-mode-hook 'zencoding-mode)
  ;(add-hook 'html-mode-hook 'zencoding-mode)
  ;(add-hook 'xml-mode-hook  'zencoding-mode)
  (add-hook 'php-mode-hook  'zencoding-mode)
  (define-key zencoding-mode-keymap (kbd "C-c C-m") 'zencoding-expand-line)
  (define-key zencoding-preview-keymap (kbd "C-c C-m") 'zencoding-preview-accept)
  (define-key zencoding-mode-keymap (kbd "M-<RET>") 'zencoding-expand-yas))

;;; less-css-mode
(my-require-and-when 'less-css-mode)

;;; Warp
(my-require-and-when 'warp
  (add-hook 'html-mode-hook 'warp-mode))
