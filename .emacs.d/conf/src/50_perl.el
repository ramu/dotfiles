;=====================
; perl
;=====================
(require 'set-perl5lib)

;; perlbrew
(require 'perlbrew)
(perlbrew-switch "perl-5.12.1")

(autoload 'cperl-mode "cperl-mode" "alternate mode for editing Perl programs" t)
(defalias 'perl-mode 'cperl-mode)

;; cperl-mode-hook
(add-hook 'cperl-mode-hook
          (function (lambda ()
            (setq cperl-indent-level 4)
            (setq cperl-indent-parens-as-block t)
            (setq cperl-indent-tabs-mode nil)
            (setq cperl-continued-statement-offset 4)
            (setq cperl-brace-offset -4)
            (setq cperl-label-offset -4)
            (setq cperl-close-paren-offset -4)
            (setq cperl-tab-always-indent nil)
            (hs-minor-mode t))))

;; perl-doc
(global-set-key "\M-p" 'cperl-perldoc)

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

