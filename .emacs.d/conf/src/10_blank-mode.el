;;; 10_blank-mode.el --- 
(require 'blank-mode)

(setq blank-space-regexp "\\(　+\\)")
(set-face-background 'blank-space "#000000")
(set-face-background 'blank-newline "#000000")


(defface blank-space
  '((((class color) (background dark))
     (:background "grey20"      :foreground "aquamarine3"))
    (((class color)　(background light))
     (:background "LightYellow" :foreground "aquamarine3"))
    (t (:inverse-video t)))
  "Face used to visualize SPACE."
  :group 'blank)



