;;;; 98_keybindings.el
(require '00_common)

;;; MEMO: mac + itermだと下記key設定が必要
; C-" -> Send Hex Codes=0x18 0x40 0x63 0x22
; C-' -> Send Hex Codes=0x18 0x40 0x63 0x27
; C-; -> Send Hex Codes=0x18 0x40 0x63 0x3B
; C-: -> Send Hex Codes=0x18 0x40 0x63 0x3A

;;; Option(ALT)はCommandと入れ替え
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote Super))

;;; prefix-keyとして利用できるように置き換え
(defvar ctl-c-map (make-keymap))
(defvar ctl-q-map (make-keymap))
(defvar alt-g-map (make-keymap))
(define-key global-map "\C-c" ctl-c-map)
(define-key global-map "\C-q" ctl-q-map)
(define-key global-map "\M-g" alt-g-map)

;;; global-set-key
(define-key global-map [?¥] [?\\])                     ; ¥はバックスラッシュに変更
(define-key cua-global-keymap cua-rectangle-mark-key 'cua-set-rectangle-mark)
(global-set-key (kbd "C-x C-b") 'bs-show)              ; バッファ一覧をまともに
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x C-i") 'helm-info-at-point)

(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-h") 'delete-backward-char)     ; C-hは後退(1文字)
(global-set-key (kbd "M-h") 'backward-kill-word)       ; M-hは後退(単語)
(global-set-key (kbd "C-t") 'dmacro-exec)              ; dmacro
(global-set-key (kbd "C-=") 'indent-region)            ; indent
(global-set-key (kbd "C-'") 'my-helm)                  ; helm
(global-set-key (kbd "M-'") 'helm-M-x)                 ; helm
(global-set-key (kbd "C-x g") 'goto-line)              ; goto-line(M-g g ---> C-x g)
(global-set-key (kbd "C-x e") 'eval-last-sexp)         ; eval-last-sexp
(global-set-key (kbd "C-c a") 'align)
(global-set-key (kbd "C-c e") 'smart_execute)          ; 50_c.el
(global-set-key (kbd "C-c n") 'toggle-transparency)    ; 01_frame.el
(global-set-key (kbd "C-c r") 'query-replace)          ; replace
(global-set-key (kbd "C-c t") 'multi-term)             ; Terminal
;(global-set-key (kbd "C-t") 'other-window-or-split)   ; 01_frame.el
(global-set-key (kbd "C-c l") 'se/make-summary-buffer) ; summarye
(global-set-key (kbd "C-c k") '(lambda () (interactive) (kill-buffer (current-buffer))))
(global-set-key (kbd "C-c C-k") '(lambda () (interactive) (kill-line 0)))
(global-set-key (kbd "C-c C-l") 'toggle-truncate-lines)
(global-set-key (kbd "C-M-i") 'indent-region)
(global-set-key (kbd "C-M-g") 'helm-do-grep)
(global-set-key (kbd "M-+") 'e2wm:start-management)
(global-set-key [f8] 'neotree-toggle)

;; magit
(global-set-key (kbd "M-g i") 'magit-init)             ; git init
(global-set-key (kbd "M-g s") 'magit-status)           ; git status
(global-set-key (kbd "M-g a") 'magit-stage-item)       ; git add
(global-set-key (kbd "M-g l") 'magit-log)              ; git add
(global-set-key (kbd "M-g c") 'magit-log-edit)         ; git commit


;;; key-chord.el
(my-require-and-when 'key-chord
  (setq key-chord-mode t)
  (setq key-chord-two-keys-delay 0.01)
  (setq key-chord-one-key-delay 0.01)
  (key-chord-define-global "gl"  'goto-line)
  (key-chord-define-global "re"  'replace-string)
  ;(key-chord-define-global ",."  "<>ﾂ･C-b")
  ;(key-chord-define-global "qq"  "the ")
  ;(key-chord-define-global "qw"  "the ")
  ;(key-chord-define c++-mode-map ";;"  "ﾂ･C-e;")
  )

;;; smartrep.el
;; 連続操作の省力化
;; http://sheephead.homelinux.org/2011/12/19/6930/
(my-require-and-when 'smartrep
  (smartrep-define-key
   global-map "C-q" '(; current window
                      ("h" . 'backward-char)
                      ("j" . (lambda () (scroll-up 1)))
                      ("k" . (lambda () (scroll-down 1)))
                      ("l" . 'forward-char)
                      ("a" . 'beginning-of-buffer)
                      ("e" . 'end-of-buffer)
                      ("b" . 'scroll-down)
                      ("SPC" . 'scroll-up)
                      ; other window
                      ("n" . (lambda () (scroll-other-window 1)))
                      ("p" . (lambda () (scroll-other-window -1)))
                      ("N" . 'scroll-other-window)
                      ("P" . (lambda () (scroll-other-window '-)))
                      ("A" . (lambda () (beginning-of-buffer-other-window 0)))
                      ("B" . (lambda () (end-of-buffer-other-window 0))))))

;;; expand-region
(my-require-and-when 'expand-region
  (global-set-key (kbd "C-@") 'er/expand-region)
  (global-set-key (kbd "C-M-@") 'er/contract-region))

;;; my-map
(defvar my-map "")
(setq my-map (make-sparse-keymap))
(mapc (lambda (x)
          (define-key my-map (car x) (cdr x))
          (global-set-key (car x) (cdr x)))
        '(("\C-c c" . quickrun)))
(easy-mmode-define-minor-mode my-mode "Grab keys" t " my-map" my-map)
