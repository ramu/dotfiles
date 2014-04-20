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
