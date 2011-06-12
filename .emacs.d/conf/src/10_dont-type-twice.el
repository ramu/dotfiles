;;; 10_dont-type-twice.el --- 
(require 'dont-type-twice)
(global-dont-type-twice t)

; Growl
(setq dt2-notify-func 'dt2-growl)
