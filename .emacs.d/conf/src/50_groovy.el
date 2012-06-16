;;; 50_groovy.el
(require 'groovy-mode)

; turn on syntax highlighting
(global-font-lock-mode 1)

(add-to-list 'auto-mode-alist '("\.groovy$" . groovy-mode))
(add-to-list 'interpreter-mode-alist '("groovy" . groovy-mode))

; make Groovy mode electric by default.
(add-hook 'groovy-mode-hook
          '(lambda ()
             (require 'groovy-electric)
             (groovy-electric-mode)
             (my-mode t)))
