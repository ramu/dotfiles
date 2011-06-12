;; 10_mode-compile.el
(require 'mode-compile)

(autoload 'mode-compile "mode-compile"
  "Command to compile current buffer file based on the major mode" t)
(global-set-key "\C-cc" 'mode-compile)
(autoload 'mode-compile-kill "mode-compile"
  "Command to kill a compilation launched by `mode-compile`" t)
; 使わない
;(global-set-key "\C-ck" 'mode-compile-kill)

(setq mode-compile-expert-p t)
(setq mode-compile-reading-time 0)

