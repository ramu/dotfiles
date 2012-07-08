;;; 10_multi-term.el ---
(require '00_common)

(my-require-and-when 'multi-term
  (setq multi-term-program "/bin/zsh")
  (set-language-environment 'utf-8)
  (prefer-coding-system 'utf-8)

  ;; ucs-normalize
  (my-require-and-when 'ucs-normalize
    (setq file-name-coding-system 'utf-8-hfs)
    (setq locale-coding-system 'utf-8-hfs)
    ;(add-hook 'term-mode-hook '(lambda () )))
  ))
