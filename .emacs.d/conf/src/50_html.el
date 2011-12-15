;;;; 50_html.el
;;; default browser
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "open")
(add-hook 'html-mode-hook (lambda ()
                            (html-autoview-mode)))


;;; zencoding-mode.el
(require 'zencoding-mode)
(add-hook 'sgml-mode-hook 'zencoding-mode)
;(add-hook 'html-mode-hook 'zencoding-mode)
;(add-hook 'xml-mode-hook  'zencoding-mode)
;(add-hook 'php-mode-hook  'zencoding-mode)
(define-key zencoding-mode-keymap (kbd "M-<RET>") 'zencoding-expand-yas)

