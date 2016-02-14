;;; 50_groovy.el
(require '00_common)

(my-require-and-when 'groovy-mode
  ; turn on syntax highlighting
  (global-font-lock-mode 1)

  (add-auto-mode 'groovy-mode "\\.groovy$")
  (add-to-list 'interpreter-mode-alist '("groovy" . groovy-mode))

  ; make Groovy mode electric by default.
  (add-hook 'groovy-mode-hook
            '(lambda ()
               (my-require-and-when 'groovy-electric
                 (groovy-electric-mode))
               (my-mode t))))
