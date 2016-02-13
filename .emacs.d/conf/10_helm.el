;;; 10_helm.el ---
(require '00_common)

(my-require-and-when 'helm-config
  (helm-mode t)

  ;; my helm
  (defun my-helm ()
    "helm command for you."
    (interactive)
    (helm-other-buffer
      '(helm-source-bookmarks
        helm-source-buffers-list
;        helm-source-imenu
        helm-source-recentf
        helm-source-info-pages
;        helm-source-emacs-commands
;        helm-source-emacs-functions
        helm-source-files-in-current-dir)
      "*my-helm*"))

  ; global key設定はまとめてやる
  (define-key helm-map (kbd "C-M-n") 'helm-next-source)
  (define-key helm-map (kbd "C-M-p") 'helm-previous-source)
  (define-key helm-map (kbd "C-h") 'delete-backward-char)
  (define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)

  ;; config
  (setq helm-idle-delay 0.1)
  (setq helm-input-idle-delay 0.1)
  (setq helm-candidate-number-limit 30)
  (setq helm-quick-update t)
  (setq helm-c-filelist-file-name (expand-file-name "~/.emacs.d/share/plugins/ruby/all.filelist"))
  (setq descbinds-helm-window-style 'split-window)
  (setq helm-enable-shortcuts 'prefix)
  (define-key helm-map "@" 'helm-select-with-prefix-shortcut)
  (setq helm-samewindow nil)
  (setq helm-split-window-in-side-p t)
  (custom-set-variables
   ;; custom-set-variables was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   )
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(helm-ff-directory ((t (:background "Black" :foreground "Orange"))))
   '(helm-ff-dotted-directory ((t (:background "brightyellow" :foreground "white")))))

  ; helm-c-moccur.el
  (my-require-and-when 'helm-c-moccur
    (setq moccur-split-word t)
    ;(global-set-key (kbd "M-s") 'helm-c-moccur-occur-by-moccur)
    (define-key isearch-mode-map (kbd "C-o") 'helm-c-moccur-from-isearch)
    (define-key isearch-mode-map (kbd "C-M-o") 'isearch-occur))

  (my-require-and-when 'helm-c-moccur)

  (my-require-and-when 'helm-css-scss
    (setq helm-css-scss-insert-close-comment-depth 2)
    (setq helm-css-scss-split-direction 'split-window-horizontally)

    (dolist ($hook '(css-mode-hook scss-mode-hook))
      (add-hook $hook (lambda ()
                        (local-set-key (kbd "C-:") 'helm-css-scss)))))

  (my-require-and-when 'helm-swoop
    (setq helm-swoop-split-with-multiple-windows nil)
    (setq helm-swoop-split-direction 'split-window-horizontally)
    (define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
    (define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop))

  (my-require-and-when 'helm-c-yasnippet
    (setq helm-yas-space-match-any-greedy t)
    (setq helm-yas-display-key-on-candidate t)
    (global-set-key (kbd "C-c y") 'helm-yas-complete)
    (yas-global-mode 1)
    (yas-load-directory (expand-file-name "~/.emacs.d/plugins/yasnippet/")))

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
    (define-key ac-complete-mode-map (kbd "C-M-]") 'ac-complete-with-helm))

  (my-require-and-when 'helm-dash
    (setq helm-dash-docsets-path (expand-file-name "~/.emacs.d/var/.docsets"))
    (setq helm-dash-min-length 3)

    (defun my-set-doctype-for-helm-dash ()
      (setq-local helm-dash-docsets
                  (case major-mode
                    (sgml-mode '("Emmet"))
                    (js2-mode '("JavaScript" "NodeJS" "UnderscoreJS" "AngularJS" "Compass" "EmberJS" "Express" "HTML" "Haml" "Jasmine" "KnockoutJS" "RequireJS" "Sass" "UnderscoreJS" "jQuery" "jQuery_Mobile"))
                    (less-css-mode '("Less"))
                    (markdown-mode '("Markdown"))
                    (css-mode '("CSS"))
                    (scss-mode '("CSS" "Compass"))
                    (shell-script-mode '("Bash"))
                    (common-lisp-mode '("Common_Lisp"))
                    (cc-mode '("C" "C++"))
                    (ruby-mode '("Ruby" "Ruby_on_Rails_4"))
                    (scala-mode '("Scala"))
                    (php-mode '("PHP"))
                    (python-mode '("Python_3"))
                    (cperl-mode '("Perl"))
                    (go-mode '("Go"))
                    (lisp-mode '("Emacs_Lisp"))
                    (coffee-mode '("CoffeeScript")))))
    (dolist (hook (list 'sgml-mode 'js2-mode-hook 'less-css-mode-hook 'markdown-mode-hook 'css-mode-hook 'scss-mode-hook 'shell-script-mode 'common-lisp-mode
                        'cc-mode 'ruby-mode 'scala-mode 'php-mode 'python-mode 'cperl-mode 'go-mode 'lisp-mode 'coffee-mode))
      (add-hook hook 'my-set-doctype-for-helm-dash))
    (setq helm-dash-completing-read-func
          (lambda ($name $docsets)
            (helm :sources `((name . ,$name)
                             (candidates . ,$docsets)
                             (action . (lambda ($cand) $cand))))))
    (defun my-helm-dash-install-docset ()
      (interactive)
      (unless (boundp 'my-helm-dash-available-docsets-cache)
        (setq my-helm-dash-available-docsets-cache (helm-dash-available-docsets)))
      (cl-letf (((symbol-function 'helm-dash-available-docsets)
                 (lambda () my-helm-dash-available-docsets-cache)))
        (helm-dash-install-docset)))
    (defun my-helm-dash-install-from-list ($list)
      (dolist ($name $list)
        (let ((helm-dash-completing-read-func
               (lambda (_i1 _i2) $name)))
          (cl-letf (((symbol-function 'helm-dash-available-docsets)
                     (lambda () nil)))
            (helm-dash-install-docset $name)))))
    ; (helm-dash-installed-docsets)
    ; (insert (format "\n%s" (helm-dash-available-docsets)))
    ; (my-helm-dash-install-from-list '("AngularJS" "BackboneJS" "Bash" "C++" "C" "CoffeeScript" "Common_Lisp" "Compass" "Emacs_Lisp" "EmberJS" "Emmet" "Express" "Go" "HTML" "Haml" "Haskell" "Jasmine" "JavaScript" "KnockoutJS" "Less" "Markdown" "NodeJS" "PHP" "Perl" "Python_3" "RequireJS" "Ruby" "Ruby_on_Rails_4" "Sass" "Scala" "UnderscoreJS" "jQuery" "jQuery_Mobile"))
    ))

