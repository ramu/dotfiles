;;;; 50_javascript.el
(require '00_common)

(my-require-and-when 'js2-mode
                    (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode)))

(my-require-and-when 'js-comint
  (setq inferior-js-program-command "env NODE_NO_READLINE=1 node")
  (add-hook 'inferior-js-mode-hook 'ansi-color-for-comint-mode-on)
  (add-hook 'js2-mode-hook '(lambda ()
                              (local-set-key "\C-x\C-e"
                                             'js-send-last-sexp)
                              (local-set-key "\C-\M-x"
                                             'js-send-last-sexp-and-go)
                              (local-set-key "\C-cb"
                                             'js-send-buffer)
                              (local-set-key "\C-c\C-b"
                                             'js-send-buffer-and-go)
                              (local-set-key "\C-cl"
                                             'js-load-file-and-go))))

(my-require-and-when 'coffee-mode
  (add-to-list 'auto-mode-alist '("\.coffee$" . coffee-mode))
  (add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))

  (define-key coffee-mode-map (kbd "C-c C-c") 'coffee-compile-buffer)
  (define-key coffee-mode-map (kbd "C-j") 'coffee-newline-and-indent)

  (defun coffee-custom ()
    "coffee-mode-hook"
    (and (set (make-local-variable 'tab-width) 2)
         (set (make-local-variable 'coffee-tab-width) 2)))
  (add-hook 'coffee-mode-hook
            '(lambda () (coffee-custom))))
