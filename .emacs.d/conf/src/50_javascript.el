;;;; 50_javascript.el
(require '00_common)

(my-require-and-when 'js2-mode
  (add-auto-mode 'js2-mode "\\.js$"))

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
  (add-auto-mode 'coffee-mode "\\.coffee$" "Cakefile")

  (define-key coffee-mode-map (kbd "C-c C-c") 'coffee-compile-buffer)
  (define-key coffee-mode-map (kbd "C-j") 'coffee-newline-and-indent)

  (defun coffee-custom ()
    "coffee-mode-hook"
    (and (set (make-local-variable 'tab-width) 2)
         (set (make-local-variable 'coffee-tab-width) 2)))
  (add-hook 'coffee-mode-hook
            '(lambda () (coffee-custom))))

(my-require-and-when 'json-mode
  (add-hook 'json-mode-hook
            '(lambda ()
               (flycheck-mode)
               (define-key json-mode-map (kbd "C-.") 'flycheck-next-error)
               (define-key json-mode-map (kbd "C-,") 'flycheck-previous-error))))
