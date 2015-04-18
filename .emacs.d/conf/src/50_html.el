;;;; 50_html.el
(require '00_common)

;;; default browser
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "open")

;;; web-mode.el
(my-require-and-when 'web-mode
  (add-to-list 'auto-mode-alist '("\\.phtml$"     . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php$" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.[agj]sp$"   . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x$"   . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb$"       . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache$"  . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml$"    . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html?$"     . web-mode))
  (defun web-mode-my-hook ()
    (setq web-mode-markup-indent-offset 2)
    (setq web-mode-css-indent-offset 2)
    (setq web-mode-code-indent-offset 2)
    (setq web-mode-enable-auto-pairing t)
    (setq web-mode-enable-auto-closing nil)
    (setq web-mode-auto-close-style 0)
    (setq web-mode-tag-auto-close-style 0))
  (add-hook 'web-mode-hook 'web-mode-my-hook)
  (custom-set-faces '(web-mode-doctype-face          ((t (:foreground "#82AE46"))))
                    '(web-mode-html-tag-face         ((t (:foreground "#E6B422" :weight bold))))
                    '(web-mode-html-attr-name-face   ((t (:foreground "#C97586"))))
                    '(web-mode-html-attr-value-face  ((t (:foreground "#82AE46"))))
                    '(web-mode-comment-face          ((t (:foreground "#D9333F"))))
                    '(web-mode-server-comment-face   ((t (:foreground "#D9333F"))))
                    '(web-mode-css-rule-face         ((t (:foreground "#A0D8EF"))))
                    '(web-mode-css-pseudo-class-face ((t (:foreground "#FF7F00"))))
                    '(web-mode-css-at-rule-face      ((t (:foreground "#FF7F00"))))))

;;; emmet-mode.el
(my-require-and-when 'emmet-mode
  (add-hook 'sgml-mode-hook 'emmet-mode)
  (add-hook 'css-mode-hook 'emmet-mode)
  ;(add-hook 'html-mode-hook 'emmet-mode)
  (add-hook 'web-mode-hook 'emmet-mode)
  ;(add-hook 'xml-mode-hook  'emmet-mode)
  (add-hook 'php-mode-hook 'emmet-mode)
  (add-hook 'emmet-mode-hook (lambda ()
                               (setq emmet-indentation 2)
                               (setq emmet-move-cursor-between-quotes t)))
  (define-key emmet-mode-keymap (kbd "C-c C-j") 'emmet-expand-yas)
  (define-key emmet-mode-keymap (kbd "C-c TAB") 'emmet-expand-line)
  (define-key emmet-preview-keymap (kbd "C-c C-m") 'emmet-preview-accept))

;;; less-css-mode
(my-require-and-when 'less-css-mode)

;;; Warp
(my-require-and-when 'warp
  (add-hook 'html-mode-hook 'warp-mode)
  (add-hook 'web-mode-hook 'warp-mode)
  (my-require-and-when 'warp-reload))

;;; scss-mode(http://d.hatena.ne.jp/CortYuming/20120110/p1)
(defun my-css-electric-pair-brace ()
  (interactive)
  (insert "{")
  (newline-and-indent)
  (newline-and-indent)
  (insert "}")
  (indent-for-tab-command)
  (previous-line)
  (indent-for-tab-command))

(defun my-css-electric-pair-brace-sameline ()
  (interactive)
  (insert "{}")
  (backward-char)
  (indent-for-tab-command))

(defun my-semicolon-ret ()
  (interactive)
  (insert ";")
  (if (search-forward "}" (point-at-eol) t)
      (progn (search-backward ";")
             (forward-char))
    (newline-and-indent)))

(my-require-and-when 'scss-mode
  (add-auto-mode 'scss-mode "\\.\\(scss\\|css\\)\\'")
  (add-hook 'scss-mode-hook 'ac-css-mode-setup)
  (add-hook 'scss-mode-hook
            (lambda ()
              (define-key scss-mode-map "{" 'my-css-electric-pair-brace)
              (define-key scss-mode-map "\M-{" 'my-css-electric-pair-brace-sameline)
              (define-key scss-mode-map ";" 'my-semicolon-ret)
              (setq css-indent-offset 2)
              (setq scss-compile-at-save nil)
              (setq ac-sources '(ac-source-yasnippet
                                 ac-source-words-in-all-buffer
                                 ac-source-dictionary))
              (flymake-mode t)))
  (add-to-list 'ac-modes 'scss-mode))

