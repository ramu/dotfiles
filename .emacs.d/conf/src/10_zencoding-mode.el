;; 10_zencoding-mode.el
(require 'zencoding-mode)

; 使用可能：sgml, html, xml, php
(add-hook 'sgml-mode-hook 'zencoding-mode)
;(add-hook 'html-mode-hook 'zencoding-mode)
;(add-hook 'xml-mode-hook  'zencoding-mode)
;(add-hook 'php-mode-hook  'zencoding-mode)

; keybindings
;(define-key zencoding-mode-keymap (kbd "M-<RET>") 'zencoding-expand-line)
(define-key zencoding-mode-keymap (kbd "M-<RET>") 'zencoding-expand-yas)
