;;; 10_flycheck.el ---
(my-require-and-when 'flycheck
  (my-require-and-when 'flycheck-color-mode-line)
  (setq flycheck-display-errors-delay '0.1)

  (flycheck-define-checker ruby-rubocop
                           "A Ruby syntax and style checker using the RuboCop tool."
                           :command ("rubocop" "--format" "emacs"
                                     (config-file "--config" flycheck-rubocoprc)
                                     source)
                           :error-patterns
                           ((warning line-start
                                     (file-name) ":" line ":" column ": " (or "C" "W") ": " (message)
                                     line-end)
                            (error line-start
                                   (file-name) ":" line ":" column ": " (or "E" "F") ": " (message)
                                   line-end))
                           :modes (enh-ruby-mode ruby-mode)))
