;;; 50_c.el
;;; Programming Language C
(require 'cc-mode)

(add-hook 'c-mode-common-hook
          '(lambda ()
              ;; ";"とRETで自動改行+インデント
              ;(c-toggle-auto-hungry-state 1)
              (define-key c-mode-map "\C-m" 'newline-and-indent)
              (c-set-offset 'substatement-open 0)
              (c-set-offset 'case-label '+)
              (c-set-offset 'arglist-cont-nonempty '+)
              (c-set-offset 'arglist-intro '+)
              (c-set-offset 'topmost-intro-cont '+)
              (c-set-offset 'arglist-close 0)
              (setq tab-width 4)
              (c-set-style "k&r")
              (setq c-basic-offset tab-width)
              (setq indent-tabs-mode nil)
              (set (make-local-variable 'eldoc-idle-delay) 0.20)
              (c-turn-on-eldoc-mode)
              (hs-minor-mode t)))


; hideif.el
; C言語のプリプロセッサを隠す
; hideshowでOK
;(require 'hideif)
;(add-hook 'c-mode-common-hook 'hide-ifdef-mode)

;;; c-eldoc
(require 'c-eldoc)
(setq c-eldoc-cpp-command "/usr/bin/cpp")
