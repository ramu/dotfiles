;; 07_history.el
; バックアップ作成
(setq make-backup-files t)
; 保存場所
(setq backup-directory-alist
      (cons (cons "\\.*$" (expand-file-name "~/.emacs.d/var/history/backup"))
            backup-directory-alist))

; 世代バックアップ
(setq version-control t)
; 5件残す
(setq kept-new-versions 5)
(setq kept-old-versions 5)
; 古いもの消すのに確認しない
(setq delete-old-versions t)
; バージョン管理下でもバックアップ
(setq vc-mode-backup-files t)

; 履歴を次回Emacs起動時にも保存する
(setq savehist-file "~/.emacs.d/var/history/history")
(savehist-mode t)
; 履歴保存件数
(setq history-length 1000)
; ログの記録行数
(setq messagep-log-max 10000)

