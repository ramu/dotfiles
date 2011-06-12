;; 10_eldoc-extension.el
(require 'eldoc)
; 使えない?
;(require 'eldoc-extension)

(setq eldoc-idle-delay 0)
(setq eldoc-echo-area-use-multiline-p t)
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)

(set-face-background 'eldoc-highlight-function-argument "#FF0000")
(set-face-bold-p 'eldoc-highlight-function-argument nil)
