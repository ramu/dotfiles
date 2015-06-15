;;; 50_markdown.el ---
(require '00_common)

(my-require-and-when 'markdown-mode
  (add-auto-mode 'markdown-mode "\\.text\\'" "\\.markdown\\'" "\\.md\\'"))

;;; Warp
(my-require-and-when 'warp
  (my-require-and-when 'warp-reload)
  (add-hook 'markdown-mode-hook 'warp-mode)
  (add-to-list 'warp-format-converter-alist
               '("\\.md\\|\\.markdown" t (lambda ()
                                           '("markdown")))))
