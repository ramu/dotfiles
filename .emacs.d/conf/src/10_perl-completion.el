;================
; perl-completion
;================
(add-hook 'cperl-mode-hook
  (lambda ()
    (require 'perl-completion)
    (add-to-list 'ac-sources 'ac-source-perl-completion)))

