;;; 50_markdown.el ---
(require '00_common)

(my-require-and-when 'markdown-mode
  (add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
  (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
  (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode)))

;;; Warp
(my-require-and-when 'warp
  (add-hook 'markdown-mode-hook 'warp-mode)
  (add-to-list 'warp-format-converter-alist
               '("\\.md\\|\\.markdown" t (lambda ()
                                           '("markdown")))))
