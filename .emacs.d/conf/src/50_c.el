;==========================
; programming language c
;==========================

(require 'cc-mode)

(add-hook 'c-mode-common-hook
          '(lambda ()
              ;; ";"とRETで自動改行+インデント
              ;(c-toggle-auto-hungry-state 1)
              (define-key c-mode-base-map "\C-m" 'newline-and-indent)
              (define-key c-mode-base-map (kbd "C-c C-c") 'smart_execute)
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
              (hs-minor-mode t)))

; (c/c++)現在開いているファイル名から拡張子を消した名称(実行ファイル)を実行
(defun smart_execute ()
  (interactive)
  (let ((execpath (format "%s%s" (file-name-directory buffer-file-name)
                          (file-name-nondirectory (file-name-sans-extension buffer-file-name)))))
    (start-process execpath "*Messages*" execpath)))

; hideif.el
; C言語のプリプロセッサを隠す
; hideshowでOK
;(require 'hideif)
;(add-hook 'c-mode-common-hook 'hide-ifdef-mode)

