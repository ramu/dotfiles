;;;; 50_javascript.el
(require '00_common)

(my-require-and-when 'js2-mode
                    (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode)))
