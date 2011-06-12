;;; 10_drill-instructor.el --- 
(require 'drill-instructor)
(setq drill-instructor-global t)

; 真鬼軍曹.el(失敗したら即終了)
;(mapc (lambda (name)
;        (fset name 'kill-emacs))
;      '(drill-instructor-alert-up
;        drill-instructor-alert-down
;        drill-instructor-alert-right
;        drill-instructor-alert-left
;        drill-instructor-alert-del
;        drill-instructor-alert-return
;        drill-instructor-alert-tab))
