;;; rainbow-delimiters.el ---
(require 'rainbow-delimiters)

(add-hook 'scheme-mode-hook 'rainbow-delimiters-mode)
(add-hook 'shell-mode-hook 'rainbow-delimiters-mode)
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)

;;; colors
(set-face-foreground 'rainbow-delimiters-depth-1-face "#EFEFEF")   ; Grey
(set-face-foreground 'rainbow-delimiters-depth-2-face "#55FF55")   ; Green
(set-face-foreground 'rainbow-delimiters-depth-3-face "#5555FF")   ; Blue
(set-face-foreground 'rainbow-delimiters-depth-4-face "#FF5555")   ; Red
(set-face-foreground 'rainbow-delimiters-depth-5-face "#FFFF55")   ; Yellow
(set-face-foreground 'rainbow-delimiters-depth-6-face "#FF55FF")   ; Purple
(set-face-foreground 'rainbow-delimiters-depth-7-face "#55FFFF")   ; light-blue
(set-face-foreground 'rainbow-delimiters-depth-8-face "#BBBBBB")   ; Grey...
(set-face-foreground 'rainbow-delimiters-depth-9-face "#999999")   ; Grey....
(set-face-foreground 'rainbow-delimiters-depth-10-face "#777777")  ; Grey...
(set-face-foreground 'rainbow-delimiters-depth-11-face "#555555")  ; Grey...
(set-face-foreground 'rainbow-delimiters-depth-12-face "#333333")  ; Grey...

;(((((((((((())))))))))))