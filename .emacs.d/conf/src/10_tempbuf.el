;;; 10_tempbuf.el --- 
(require 'tempbuf)
(setq tempbuf-life-extension-ratio 0
      tempbuf-minimum-timeout 1)

;; 適当なモードに切り替えた時点で不要バッファ削除
(add-hook 'find-file-hooks 'turn-on-tempbuf-mode)
(add-hook 'dired-mode-hook 'turn-on-tempbuf-mode)
(add-hook 'compilation-mode-hook 'turn-on-tempbuf-mode)
(add-hook 'completion-list-mode-hook 'turn-on-tempbuf-mode)
(add-hook 'view-mode-hook 'turn-on-tempbuf-mode)
