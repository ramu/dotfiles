;;; 10_helm.el ---
(require '00_common)

(my-require-and-when 'helm-config
  (defun my-helm ()
    "helm command for you."
    (interactive)
    (helm-other-buffer
      '(helm-c-source-bookmarks
;        helm-c-source-buffers+
        helm-c-source-buffers-list
;        helm-c-source-imenu
        helm-c-source-recentf
;        helm-c-source-man-pages
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
  (helm-lisp-complete-symbol-set-timer 150)
  (setq helm-samewindow nil))
