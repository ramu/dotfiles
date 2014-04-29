;;; 10_helm.el ---
(require '00_common)

(my-require-and-when 'helm-config
  (helm-mode t)

  ;; my helm
  (defun my-helm ()
    "helm command for you."
    (interactive)
    (helm-other-buffer
      '(helm-c-source-bookmarks
        helm-c-source-buffers-list
;        helm-c-source-imenu
        helm-c-source-recentf
        helm-c-source-info-pages
;        helm-c-source-emacs-commands
;        helm-c-source-emacs-functions
        helm-c-source-files-in-current-dir)
      "*my-helm*"))

  ; global key設定はまとめてやる
  (define-key helm-map (kbd "C-M-n") 'helm-next-source)
  (define-key helm-map (kbd "C-M-p") 'helm-previous-source)

  ;; config
  (setq helm-idle-delay 0.1)
  (setq helm-input-idle-delay 0.1)
  (setq helm-candidate-number-limit 30)
  (setq helm-quick-update t)
  (setq helm-c-filelist-file-name "/Users/ramusara/.emacs.d/share/plugins/ruby/all.filelist")
  (setq descbinds-helm-window-style 'split-window)
  (setq helm-enable-shortcuts 'prefix)
  (define-key helm-map "@" 'helm-select-with-prefix-shortcut)
  (setq helm-samewindow nil)

  ; helm-c-moccur.el
  (my-require-and-when 'helm-c-moccur
    (setq moccur-split-word t)
    (global-set-key (kbd "M-s") 'helm-c-moccur-occur-by-moccur)
    (define-key isearch-mode-map (kbd "C-o") 'helm-c-moccur-from-isearch)
    (define-key isearch-mode-map (kbd "C-M-o") 'isearch-occur)
    (setq anything-c-moccur-anything-idle-delay 0.1
          anything-c-moccur-higligt-info-line-flag t
          anything-c-moccur-enable-auto-look-flag t
          anything-c-moccur-enable-initial-pattern t))

  (my-require-and-when 'helm-c-moccur)

  (my-require-and-when 'helm-c-yasnippet
    (setq helm-yas-space-match-any-greedy t)
    (global-set-key (kbd "C-c C-y") 'helm-yas-complete)
    (yas-global-mode 1)
    (yas-load-directory "/Users/ramusara/.emacs.d/plugins/yasnippet/"))

  (my-require-and-when 'helm-descbinds
    (helm-descbinds-mode))

  (my-require-and-when 'helm-gtags
    (add-hook 'c-mode-hook 'helm-gtags-mode)
    (add-hook 'helm-gtags-mode-hook
              '(lambda ()
                 (local-set-key (kbd "M-t") 'helm-gtags-find-tag)
                 (local-set-key (kbd "M-r") 'helm-gtags-find-rtag)
                 (local-set-key (kbd "M-s") 'helm-gtags-find-symbol)
                 (local-set-key (kbd "C-t") 'helm-gtags-pop-stack))))

  (my-require-and-when 'helm-pydoc)

  (my-require-and-when 'helm-rails)

  (my-require-and-when 'ac-helm
    (define-key ac-complete-mode-map (kbd "C-M-]") 'ac-complete-with-helm)))
