;;; 50_ruby.el ---
(require 'ruby-mode)
(require 'ruby-block)
(require 'ruby-electric)

(setq ruby-indent-level 2)
(setq ruby-indent-tabs-mode nil)
(setq auto-mode-alist (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
(setq interpreter-mode-alist (append '(("ruby" . ruby-mode)) interpreter-mode-alist))
(autoload 'run-ruby "inf-ruby" "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby" "Set local key defs for inf-ruby in ruby-mode")
(add-hook 'ruby-mode-hook
          '(lambda ()
             (inf-ruby-keys)
             ;;; ruby-electric
             (ruby-electric-mode t)
             ;;; ruby-block
             (ruby-block-mode t)
             (ruby-block-highlight-toggle t)
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
(require 'rvm)
(rvm-use-default)

;;; 10_rsense.el ---
(require 'cl)
(require 'rsense)
(setq rsense-home "/opt/rsense")
(add-to-list 'load-path (concat rsense-home "/etc"))
