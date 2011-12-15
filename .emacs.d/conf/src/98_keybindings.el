;;;; 98_keybindings.el

;;; Option(ALT)はCommandと入れ替え
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))

;;; global-set-key
(define-key global-map [?¥] [?\\])                     ; ¥はバックスラッシュに変更
(global-set-key (kbd "C-x C-b") 'bs-show)              ; バッファ一覧をまともに
(global-set-key (kbd "C-h") 'delete-backward-char)     ; C-hは後退(1文字)
(global-set-key (kbd "M-h") 'backward-kill-word)       ; M-hは後退(単語)
(global-set-key (kbd "C-t") 'fold-dwim-toggle)         ; 折りたたみ
(global-set-key (kbd "C-=") 'indent-region)            ; indent
(global-set-key (kbd "C-;") 'my-anything)
(global-set-key (kbd "M-;") 'anything-execute-extended-command)
(global-set-key (kbd "C-x g") 'goto-line)              ; goto-line(M-g g ---> C-x g)
(global-set-key (kbd "C-x e") 'eval-last-sexp)         ; eval-last-sexp
(global-set-key (kbd "C-c a") 'align)
(global-set-key (kbd "C-c e") 'smart_execute)          ; 50_c.el
(global-set-key (kbd "C-c n") 'toggle-transparency)    ; 01_frame.el
(global-set-key (kbd "C-c r") 'query-replace)          ; replace
(global-set-key (kbd "C-c t") 'multi-term)             ; Terminal
;(global-set-key (kbd "C-t") 'other-window-or-split)   ; 01_frame.el
(global-set-key (kbd "C-c l") 'se/make-summary-buffer) ; summarye
(global-set-key (kbd "C-c C-k") '(lambda () (interactive) (kill-line 0)))
(global-set-key (kbd "C-M-i") 'indent-region)
(global-set-key (kbd "C-M-g") 'anything-grep)
(global-set-key (kbd "C-M-y") 'anything-show-kill-ring)
;; magit
(global-set-key (kbd "M-g i") 'magit-init)             ; git init
(global-set-key (kbd "M-g s") 'magit-status)           ; git status
(global-set-key (kbd "M-g a") 'magit-stage-item)       ; git add
(global-set-key (kbd "M-g l") 'magit-log)              ; git add
(global-set-key (kbd "M-g c") 'magit-log-edit)         ; git commit


;;; key-chord.el
(require 'key-chord)
(setq key-chord-mode t)
(setq key-chord-two-keys-delay 0.01)
(setq key-chord-one-key-delay 0.01)
(key-chord-define-global "gl"  'goto-line)
(key-chord-define-global "re"  'replace-string)
;(key-chord-define-global ",."  "<>ﾂ･C-b")
;(key-chord-define-global "qq"  "the ")
;(key-chord-define-global "qw"  "the ")
;(key-chord-define c++-mode-map ";;"  "ﾂ･C-e;")


;;; my-map
(defvar my-map "")
(setq my-map (make-sparse-keymap))
(mapc (lambda (x)
          (define-key my-map (car x) (cdr x))
          (global-set-key (car x) (cdr x)))
        '(("\C-c\C-c" . quickrun)))
(easy-mmode-define-minor-mode my-mode "Grab keys" t "" my-map)
