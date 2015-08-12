;;; 50_perl.el
(require '00_common)

(my-require-and-when 'set-perl5lib-path)
(my-require-and-when 'cperl-mode)

;; perlbrew
(my-require-and-when 'perlbrew
  (perlbrew-switch "perl-5.23.1"))

(my-autoload-and-when 'cperl-mode "cperl-mode"
                      (defalias 'perl-mode 'cperl-mode)

                      ;; cperl-mode-hook
                      (add-hook 'cperl-mode-hook
                                (lambda ()
                                  ;; perl-doc
                                  (local-set-key (kbd "M-p") 'cperl-perldoc)
                                  (setq cperl-indent-level 4)
                                  (setq cperl-indent-parens-as-block t)
                                  (setq cperl-indent-tabs-mode nil)
                                  (setq cperl-continued-statement-offset 4)
                                  (setq cperl-brace-offset -4)
                                  (setq cperl-label-offset -4)
                                  (setq cperl-close-paren-offset -4)
                                  (setq cperl-tab-always-indent nil)
                                  (hs-minor-mode t))))

;; perl-tidy
(defun perltidy-region ()
  "Run perltidy on the current region."
  (interactive)
  (save-excursion
    (shell-command-on-region (point) (mark) "perltidy -q" nil t)))
(defun perltidy-defun ()
  "Run perltidy on the current defun."
  (interactive)
  (save-excursion (mark-defun)
    (perltidy-region)))


;; リージョンを選択して実行
(defun perl-eval (beg end)
  "Run selected region as Perl code"
  (interactive "r")
  (save-excursion
    (shell-command-on-region beg end "perl")))

