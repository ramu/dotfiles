;;;; 50_lisp.el ---
(require '00_common)

;;; lispxmp.el
(my-require-and-when 'lispxmp
  (define-key emacs-lisp-mode-map (kbd "C-c C-d") 'lispxmp))

;;; lambda-mode.el
; lambdaをλで表示
(my-require-and-when 'lambda-mode
  (setq lambda-symbol (string (make-char 'greek-iso8859-7 107))))

;;; eval-sexp-fu.el
;; Tiny functionality enhancements for evaluating sexps
;; http://d.hatena.ne.jp/hchbaw/20091119/1258641758
;; http://www.emacswiki.org/emacs/eval-sexp-fu.el
(my-require-and-when 'eval-sexp-fu
  (turn-on-eval-sexp-fu-flash-mode))

;;; slime.el
;; (Common) Lispのための統合開発環境
;; http://common-lisp.net/project/slime/
(my-require-and-when 'slime
  (setq inferior-lisp-program "sbcl")
  (setq slime-net-coding-system 'utf-8-unix)
  (add-hook 'lisp-mode-hook (lambda ()
                              (slime-mode t))))

;;; auto-complete(slime)
(my-require-and-when 'ac-slime
  (add-hook 'slime-mode-hook 'set-up-slime-ac)
  (add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
  (eval-after-load "auto-complete" '(add-to-list 'ac-modes 'slime-repl-mode)))

;;; hyperspec
;; Common Lisp Documentation
(my-require-and-when 'hyperspec
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
  (slime-setup '(slime-repl slime-fancy slime-banner)))
