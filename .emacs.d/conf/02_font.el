;;;; 02_font.el
(set-language-environment "Japanese")
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)

(global-font-lock-mode t)                                      ; 文字色付ける
(set-face-foreground 'font-lock-comment-face "#DD3300")
(set-face-foreground 'font-lock-string-face "#FF0000")
(set-face-foreground 'font-lock-function-name-face "#3030FF")
(set-face-foreground 'font-lock-builtin-face "#888")
(set-face-foreground 'font-lock-keyword-face "#FF00FF")
(set-face-foreground 'font-lock-type-face "#00FF00")
(set-face-foreground 'font-lock-constant-face "#FFFF00")
(set-face-foreground 'minibuffer-prompt "#FFFF00")
(auto-compression-mode t)                                      ; 日本語infoの文字化け防止
(setq-default line-spacing 2)                                  ; 行間設定
; tab幅=4, tabはspaceにする。
(setq tab-width 4)
(setq indent-tabs-mode nil)

; font
(add-to-list 'default-frame-alist '(font . "ricty-13"))
