;;; 50_ruby.el ---
(require '00_common)

(my-require-and-when 'ruby-mode
  (my-require-and-when 'ruby-block)
  (my-require-and-when 'ruby-electric)
  (my-require-and-when 'inf-ruby)

  (setq ruby-indent-level 2)
  (setq ruby-indent-tabs-mode nil)
  (add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
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
               ;; 何もしない
               ;(setq ruby-block-highlight-toggle 'noghing)
               ;; ミニバッファに表示
               ;(setq ruby-block-highlight-toggle 'minibuffer)
               ;; オーバレイする
               ;(setq ruby-block-highlight-toggle 'overlay)
               ;; ミニバッファに表示し, かつ, オーバレイする.
               ;(setq ruby-block-highlight-toggle t)
               ;;; rsense
               (add-to-list 'ac-sources 'ac-source-rsense-method)
               (add-to-list 'ac-sources 'ac-source-rsense-constant)
               ))

  ;;; rvm
  (my-require-and-when 'rvm
    (rvm-use-default))

  ;;; rsense.el
  (my-require-and-when 'rsense
    (setq rsense-home "/opt/rsense")
    (add-to-list 'load-path (concat rsense-home "/etc"))))
