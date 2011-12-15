;;; 10_multi-term.el ---
(require 'multi-term)
(setq multi-term-program "/bin/zsh")
(set-language-environment 'utf-8)
(prefer-coding-system 'utf-8)

;; ucs-normalize
(require 'ucs-normalize)
(setq file-name-coding-system 'utf-8-hfs)
(setq locale-coding-system 'utf-8-hfs)
;(add-hook 'term-mode-hook '(lambda () ))

