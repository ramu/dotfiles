;;; 10_dired.el --- 
; diredでファイル名変更できる - wdired.el
(require 'dired)
(require 'dired+)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

;(defvar diredp-file-name 'diredp-file-name)
(set-face-foreground 'diredp-file-name "#FFFFFF")
(set-face-foreground 'diredp-file-suffix "#FFFFFF")

;(set-face-foreground 'diredp-dir-priv "#FFFFFF")
(set-face-foreground 'diredp-dir-priv "#009900")
(set-face-background 'diredp-dir-priv "#000000")

(set-face-foreground 'diredp-number "#DDAA33")
