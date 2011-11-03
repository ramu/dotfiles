;;; 90_calendar.el ---
(require 'calendar)

;; keybind
(define-key calendar-mode-map "f" 'calendar-forward-day)
(define-key calendar-mode-map "n" 'calendar-forward-day)
(define-key calendar-mode-map "b" 'calendar-backward-day)

;; 祝日をマークする
(setq calendar-mark-holidays-flag t)
(require 'japanese-holidays)
(setq calendar-holidays
      (append japanese-holidays holiday-local-holidays holiday-other-holidays))

;; 今日をマークする
(add-hook 'today-visible-calendar-hook 'calendar-mark-today)

;; 日曜日をマークする
(setq calendar-weekend-marker 'diary)
(add-hook 'today-visible-calendar-hook 'calendar-mark-weekend)
(add-hook 'today-invisible-calendar-hook 'calendar-mark-weekend)

;; japanese-holidays
(add-hook 'calendar-load-hook
          (lambda ()
            (setq calendar-holidays (append japanese-holidays local-holidays other-holidays))))


;;; calfw
(require 'calfw)
;;; (cfw:open-calendar-buffer)
