;================
; c-eldoc
;================
(require 'c-eldoc)
(setq c-eldoc-cpp-command "/usr/bin/cpp")
(add-hook 'c-mode-hook
  '(lambda ()
    (set (make-local-variable 'eldoc-idle-delay) 0.20)
    (c-turn-on-eldoc-mode)
  ))

