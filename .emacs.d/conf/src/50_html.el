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
  (add-hook 'emmet-mode-hook (lambda () (setq emmet-indentation 2)))
  (define-key emmet-mode-keymap (kbd "C-j") nil)
  (define-key emmet-mode-keymap (kbd "C-c C-m") 'emmet-expand-line)
  (define-key emmet-preview-keymap (kbd "C-c C-m") 'emmet-preview-accept))

;;; less-css-mode
(my-require-and-when 'less-css-mode)

;;; Warp
(my-require-and-when 'warp
  (add-hook 'html-mode-hook 'warp-mode))
