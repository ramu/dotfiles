;;; 10_slime.el ---
(require 'slime)

(setq inferior-lisp-program "sbcl")
(setq slime-net-coding-system 'utf-8-unix)

(add-hook 'lisp-mode-hook (lambda ()
                            (slime-mode t)
                            ))

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
(defadvice common-lisp-hyperspec
  (around hyperspec-lookup-w3m () activate)
  (let* ((window-configuration (current-window-configuration))
         (browse-url-browser-function
          `(lambda (url new-window)
             (w3m-browse-url url nil)
             (let ((hs-map (copy-keymap w3m-mode-map)))
               (define-key hs-map (kbd "q")
                 (lambda ()
                   (interactive)
                   (kill-buffer nil)
                   (set-window-configuration ,window-configuration)))
               (use-local-map hs-map)))))
    ad-do-it))


(slime-setup '(slime-repl slime-fancy slime-banner))
