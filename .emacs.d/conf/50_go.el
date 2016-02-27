;;; 50_go.el ---
(require '00_common)

(my-require-and-when 'go-mode
  (my-require-and-when 'go-autocomplete)
  (add-hook 'before-save-hook 'gofmt-before-save))
