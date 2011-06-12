;================
; elscreen
;================

(require 'elscreen)
;(require 'elscreen-buffer-list)

; 自動でスクリーン作成
(defmacro elscreen-create-automatically (ad-do-it)
  `(if (not (elscreen-one-screen-p))
       ,ad-do-it
     (elscreen-create)
     (elscreen-notify-screen-modification 'force-immediately)
     (elscreen-message "New screen is automatically created")))
(defadvice elscreen-next (around elscreen-create-automatically activate)
  (elscreen-create-automatically ad-do-it))
(defadvice elscreen-previous (around elscreen-previous activate)
  (elscreen-create-automatically ad-do-it))
(defadvice elscreen-toggle (around elscreen-create-automatically activate)
  (elscreen-create-automatically ad-do-it))

