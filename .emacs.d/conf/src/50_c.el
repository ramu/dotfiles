;;; 50_c.el
;;; Programming Language C
(require '00_common)

(my-require-and-when 'cc-mode
  (add-hook 'c-mode-common-hook
            '(lambda ()
                ;; ";"とRETで自動改行+インデント
                ;(c-toggle-auto-hungry-state 1)
                (define-key c-mode-map "\C-m" 'newline-and-indent)
                (define-key c-mode-map "\C-]" 'find-tag)
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
  ;(my-require-and-when 'hideif
  ;  (add-hook 'c-mode-common-hook 'hide-ifdef-mode))

  ;;; c-eldoc
  (my-require-and-when 'c-eldoc
  (setq c-eldoc-cpp-command "/usr/bin/cpp")))
