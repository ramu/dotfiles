;;; 99_last_config.el ---
; 最後に設定したい項目用
(require '00_common)

;; 言語／文字コードに関する設定
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8-unix)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
;(setq default-buffer-file-coding-system 'utf-8)

(put 'upcase-region 'disabled nil)

(my-require-and-when 'server
  (unless (server-running-p)
    (server-start)))
