;;;; 11_buffer.el
(require '00_common)

;;; tempbuf.el
;; 適当なモードに切り替えた時点で不要バッファ削除
(my-require-and-when 'tempbuf
  (setq tempbuf-life-extension-ratio 0
        tempbuf-minimum-timeout 1)
  (add-hook 'find-file-hooks 'turn-on-tempbuf-mode)
  (add-hook 'dired-mode-hook 'turn-on-tempbuf-mode)
  (add-hook 'compilation-mode-hook 'turn-on-tempbuf-mode)
  ;(add-hook 'completion-list-mode-hook 'turn-on-tempbuf-mode)
  ;(add-hook 'view-mode-hook 'turn-on-tempbuf-mode)
  )

;;; auto-save-buffers.el
;; 自動保存
;; http://0xcc.net/misc/auto-save/
(my-require-and-when 'auto-save-buffers
  (run-with-idle-timer 10.0 t 'auto-save-buffers))
