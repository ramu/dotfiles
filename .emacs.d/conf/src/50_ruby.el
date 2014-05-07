;;; 50_ruby.el ---
(require '00_common)

(my-require-and-when 'ruby-mode
  (my-require-and-when 'ruby-block)
  (my-require-and-when 'ruby-electric)
  (my-require-and-when 'inf-ruby)
  (my-require-and-when 'rubocop)

  (setq ruby-indent-level 2)
  (setq ruby-indent-tabs-mode nil)
  (add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
  (setq interpreter-mode-alist (append '(("ruby" . ruby-mode)) interpreter-mode-alist))
  (add-hook 'ruby-mode-hook
            '(lambda ()
               (inf-ruby-minor-mode)
               ;;; ruby-electric
               (ruby-electric-mode t)
               ;;; ruby-block
               (ruby-block-mode t)
               (setq ruby-block-highlight-toggle t)
               (setq ruby-block-delay 0)
               ;;; rsense
               (add-to-list 'ac-sources 'ac-source-rsense-method)
               (add-to-list 'ac-sources 'ac-source-rsense-constant)
               (define-key ruby-mode-map (kbd "C-c .") 'rsense-complete)
               (define-key ruby-mode-map (kbd "C-?") 'rsense-type-help)
               ;;; rubocop
               (rubocop-mode)
               ;;; flycheck
               (flycheck-mode)
               (define-key ruby-mode-map (kbd "C-.") 'flycheck-next-error)
               (define-key ruby-mode-map (kbd "C-,") 'flycheck-previous-error)))

  (my-require-and-when 'rbenv
    (setq rbenv-executable "rbenv")
    (rbenv-use-global)
    (global-rbenv-mode))

  (my-require-and-when 'rsense
    (setq rsense-home (expand-file-name "~/.emacs.d/share/rsense-0.3"))
    (add-to-list 'load-path (concat rsense-home "/etc"))))

;; rails
(my-require-and-when 'rinari
  (setq rinari-minor-mode-prefixes (list "'"))
  (add-hook 'ruby-mode-hook 'rinari-minor-mode)
  (add-hook 'coffee-mode-hook 'rinari-minor-mode)

  (my-require-and-when 'rspec-mode
    (eval-after-load 'rspec-mode '(rspec-install-snippets)))

  (my-require-and-when 'rhtml-mode
    (add-hook 'rhtml-mode-hook (lambda () (rinari-launch)))))
