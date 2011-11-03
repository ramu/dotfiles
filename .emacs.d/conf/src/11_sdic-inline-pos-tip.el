;;; 11_sdic-inline-pos-tip.el ---
(require 'sdic-inline-pos-tip)
(setq sdic-inline-search-func 'sdic-inline-search-word-with-stem)
(setq sdic-inline-display-func 'sdic-inline-pos-tip-show)
(define-key sdic-inline-map (kbd "C-c C-p") 'sdic-inline-pos-tip-show)

(setq transient-mark-mode t)

