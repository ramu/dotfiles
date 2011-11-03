;;; 10_slime.el ---
(require 'slime)

(setq inferior-lisp-program "sbcl")
(setq slime-net-coding-system 'utf-8-unix)

(add-hook 'lisp-mode-hook (lambda ()
                            (slime-mode t)
                            ))
;(add-hook 'repl-mode-hook (lambda ()
;                            (setq show-trailing-whitespace nil)
;                            ))

;; auto-complete
(require 'ac-slime)
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'slime-repl-mode))

;; hyperspec
(require 'hyperspec)
(setq common-lisp-hyperspec-root         (concat "file://" (expand-file-name "~/.emacs.d/share/slime/HyperSpec/"))
      common-lisp-hyperspec-symbol-table (expand-file-name "~/.emacs.d/share/slime/HyperSpec/Data/Map_Sym.txt"))



(slime-setup '(slime-repl slime-fancy slime-banner))
