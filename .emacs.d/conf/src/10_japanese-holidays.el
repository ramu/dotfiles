;; 10_japanese-holidays.el
(add-hook 'calendar-load-hook
          (lambda ()
                  (require 'japanese-holidays)
                  (setq calendar-holidays
                        (append japanese-holidays local-holidays other-holidays))))
