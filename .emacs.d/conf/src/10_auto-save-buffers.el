;;; 10_auto-save-buffers.el --- 
(require 'auto-save-buffers)
(run-with-idle-timer 10.0 t 'auto-save-buffers)

