;;;; 07_history.el
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


;;; kill-summary.el
;; キルリングの一覧を表示し選択ヤンクできるようにする
(autoload 'kill-summary "kill-summary" nil t)
(define-key global-map (kbd "C-x C-y") 'kill-summary)

;;; undo-tree.el
;; undo の履歴を木構造で表示、操作
(require 'undo-tree)
(global-undo-tree-mode)
(setq undo-tree-visualizer-timestamps t)

;;; windows.el
;; ウィンドウの分割形態の切り替え
(require 'windows)
(win:startup-with-window)
(define-key ctl-x-map "C" 'see-you-again)

;;; revive.el
;; 開いてるバッファ状態を保存／復元
;(autoload 'save-current-configuration "revive" "Save status" t)
;(autoload 'resume "revive" "Resume Emacs" t)
;(autoload 'wipe "revive" "Wipe emacs" t)
;(add-hook 'kill-emacs-hook 'save-current-configuration)
;(resume)

;;; recentf-ext.el
;; recentfの拡張。switch-to-bufferでアクセスしたファイルも対象、diredも対象
;; http://d.hatena.ne.jp/rubikitch/20091224/recentf
(require 'recentf-ext)
(setq recentf-max-items 10)
(setq recentf-max-saved-items 20)
(setq recentf-save-file (expand-file-name"~/.emacs.d/var/.recentf"))

;;; session.el
;; mini buffer や kill-ring 等の履歴を次回起動時に利用できる
(require 'session)
(setq session-initialize '(de-saveplace session keys menus places)
      session-globals-include '((kill-ring 50)
                                (session-file-alist 500 t)
                                (file-name-history 10000)))
(setq session-globals-max-string 100000000)
(setq history-length t)
(setq session-save-file (expand-file-name "~/.emacs.d/var/.session"))
(add-hook 'after-init-hook 'session-initialize)
