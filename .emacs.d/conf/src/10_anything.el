;; 10_anything.el
(require '00_common)

(my-require-and-when 'anything
  (my-require-and-when 'anything-startup)
  (my-require-and-when 'anything-complete)
  (my-require-and-when 'anything-show-completion)

  ;; my anything
  (defun my-anything ()
    "Anything command for you."
    (interactive)
    (anything-other-buffer
      '(anything-c-source-bookmarks
        anything-c-source-buffers+
        anything-c-source-imenu
        anything-c-source-recentf
        anything-c-source-man-pages
  ;      anything-c-source-info-pages
        anything-c-source-emacs-commands
        anything-c-source-emacs-functions
        anything-c-source-files-in-current-dir)
      "*my-anything*"))
  ; global key設定はまとめてやる
  (define-key anything-map (kbd "C-M-n") 'anything-next-source)
  (define-key anything-map (kbd "C-M-p") 'anything-previous-source)

  ;; config
  (setq anything-idle-delay 0.1)
  (setq anything-input-idle-delay 0.1)
  (setq anything-candidate-number-limit 30)
  (setq anything-quick-update t)
  (setq anything-c-filelist-file-name "/Users/ramusara/.emacs.d/share/plugins/ruby/all.filelist")
  (setq anything-enable-shortcuts 'prefix)
  (define-key anything-map "@" 'anything-select-with-prefix-shortcut)
  (anything-lisp-complete-symbol-set-timer 150)
  (setq anything-samewindow nil)

  ; anything-c-moccur.el
  (my-require-and-when 'anything-c-moccur
    (setq moccur-split-word t)
    (global-set-key (kbd "M-s") 'anything-c-moccur-occur-by-moccur)
    (define-key isearch-mode-map (kbd "C-o") 'anything-c-moccur-from-isearch)
    (define-key isearch-mode-map (kbd "C-M-o") 'isearch-occur)
    (setq anything-c-moccur-anything-idle-delay 0.1
          anything-c-moccur-higligt-info-line-flag t
          anything-c-moccur-enable-auto-look-flag t
          anything-c-moccur-enable-initial-pattern t))

  ; anything-ipython
  (my-require-and-when 'ipython
    (my-require-and-when 'anything-ipython
      (when (require 'anything-show-completion nil t)
        (use-anything-show-completion 'anything-ipython-complete '(length initial-pattern)))
        (add-hook 'python-mode-hook #'(lambda () (define-key py-mode-map (kbd "M-<tab>") 'anything-ipython-complete)))
        (add-hook 'ipython-shell-hook #'(lambda () (define-key py-mode-map (kbd "M-<tab>") 'anything-ipython-complete)))))

  ; anything-c-adaptive-history
  (setq anything-c-adaptive-history-file "~/.emacs.d/var/anything-c-adaptive-history")

  ; anything-mac-itunes.el
  (when (eq system-type 'darwin)
    (my-require-and-when 'anything-mac-itunes
      (global-set-key (kbd "C-c C-;") 'anything-mac-itunes)
      (global-set-key (kbd "C-c C-b") 'anything-mac-itunes-back-track)
      (global-set-key (kbd "C-c C-n") 'anything-mac-itunes-next-track)
      (global-set-key (kbd "C-c C-p") 'anything-mac-itunes-playpause-track)
      (global-set-key (kbd "C-c C-i") 'anything-mac-itunes-show-current-track-info)))

  ; anything-c-yasnippet
  (my-require-and-when 'yasnippet
    (my-require-and-when 'anything-c-yasnippet
      (setq anything-c-yas-space-match-any-greedy t)
      (global-set-key (kbd "C-c y") 'anything-c-yas-complete)
      (defun my-anything-c-yas-complete ()
        (interactive)
        (let (word start end)
          (save-excursion
            (setq end (point))
            (re-search-backward "^\\|\\<\\w")
            (setq start (point))
            (setq word (buffer-substring-no-properties start end)))
          (if (or (not (string-match "\\w+" word))
                  (memq (get-text-property (point) 'face)
                        '(font-lock-comment-face
                          font-lock-doc-face
                          font-lock-string-face)))
              (funcall (or (lookup-key (current-local-map) (kbd "TAB"))
                           (lookup-key (current-global-map) (kbd "TAB"))))
            ;; anything-c-yasnippet
            (anything-c-yas-complete)
          )))
      (setq-default yas/fallback-behavior '(apply my-anything-c-yas-complete))))

  ;; anything-font-families
  (defun anything-font-families ()
    "Preconfigured `anything' for font family."
    (interactive)
    (flet ((anything-mp-highlight-match () nil))
      (anything-other-buffer
       '(anything-c-source-font-families)
       "*anything font families*")))
  (defun anything-font-families-create-buffer ()
    (with-current-buffer
        (get-buffer-create "*Fonts*")
      (loop for family in (sort (delete-duplicates (font-family-list)) 'string<)
            do (insert
                (propertize (concat family "\n")
                            'font-lock-face
                            (list :family family :height 2.0 :weight 'bold))))
      (font-lock-mode 1)))
  (defvar anything-c-source-font-families
        '((name . "Fonts")
          (init lambda ()
                (unless (anything-candidate-buffer)
                  (save-window-excursion
                    (anything-font-families-create-buffer))
                  (anything-candidate-buffer
                   (get-buffer "*Fonts*"))))
          (candidates-in-buffer)
          (get-line . buffer-substring)
          (action
           ("Copy Name" lambda
            (candidate)
            (kill-new candidate))
           ("Insert Name" lambda
            (candidate)
            (with-current-buffer anything-current-buffer
              (insert candidate))))))

  ;; anything-top
  (setq anything-c-top-command "COLUMNS=%s top -n 1")

  ;; ac-anything
  (my-require-and-when 'ac-anything
    ;(define-key ac-complete-mode-map (kbd "C-:") 'ac-complete-with-anything)
    (define-key ac-complete-mode-map (kbd "C-M-]") 'ac-complete-with-anything))

  ;; persistent-actionを自動的に実行し、任意の箇所をハイライト
  ;; describe-anything
  (my-require-and-when 'descbinds-anything
    (setq descbinds-anything-window-style 'split-window)
    (descbinds-anything-install)))

