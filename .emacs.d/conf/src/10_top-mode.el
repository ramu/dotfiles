;;; 10_top-mode.el --- 
(require 'top-mode)

(defun topo-auto-refresh (rate)
  (interactive "nTop refresh rate (seconds): ")
  (progn
    (cancel-function-timers 'top)
    (if (not (zerop rate))
        (setq *top-refresh-timer*
              (run-with-timer 2 rate 'top)))))
(define-key top-mode-map "A" 'top-auto-refresh)
