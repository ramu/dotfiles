;;;; 07_history.el
(require '00_common)

(setq make-backup-files t)     ; バックアップ作成
(setq version-control t)       ; 世代バックアップ
(setq delete-old-versions t)   ; 古いもの消すのに確認しない
(setq vc-mode-backup-files t)  ; バージョン管理下でもバックアップ
; 保存場所
(setq backup-directory-alist
  (cons (cons "\\.*$" (expand-file-name "~/.emacs.d/var/history/backup"))
    backup-directory-alist))
; 5件残す
(setq kept-new-versions 5)
(setq kept-old-versions 5)
;; 履歴を次回Emacs起動時にも保存する
(setq savehist-file "~/.emacs.d/var/history/history")
(savehist-mode t)
(setq history-length 1000)     ; 履歴保存件数
(setq messagep-log-max 10000)  ; ログの記録行数

;;; recentf
(my-require-and-when 'recentf
  (recentf-mode 1)
  (setq recentf-save-file "~/.emacs.d/var/.recentf")
  (setq recentf-max-saved-items 1000)
  (setq recentf-auto-cleanup 10)
  (setq recentf-exclude '(".recentf"))
  (setq recentf-auto-save-timer (run-with-idle-timer 30 t 'recentf-save-list)))

;;; undo-tree.el
; undo の履歴を木構造で表示、操作
(my-require-and-when 'undo-tree
  (global-undo-tree-mode)
  (define-key undo-tree-map (kbd "C-?") nil)
  (setq undo-tree-visualizer-timestamps t))

;;; windows.el
;; ウィンドウの分割形態の切り替え
(my-require-and-when 'windows
  (win:startup-with-window)
  (define-key ctl-x-map "C" 'see-you-again))

;;; session.el
;; mini buffer や kill-ring 等の履歴を次回起動時に利用できる
(my-require-and-when 'session
  (setq session-initialize '(de-saveplace session keys menus places)
        session-globals-include '((kill-ring 50)
  (session-file-alist 500 t)
  (file-name-history 10000)))
  (setq session-globals-max-string 100000000)
  (setq history-length t)
  (setq session-save-file (expand-file-name "~/.emacs.d/var/.session"))
  (add-hook 'after-init-hook 'session-initialize))

;;; volatile-highlights.el
;; Minor mode for visual feedback on some operations in Emacs.
(my-require-and-when 'volatile-highlights
  (volatile-highlights-mode t))

