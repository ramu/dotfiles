;;;; 90_input.el ---
(require '00_common)

;;; sequential-config.el
;; 同じコマンドを連続実行することで挙動を変える（行頭→先頭など）
;; http://d.hatena.ne.jp/rubikitch/20090219/sequential_command
(my-require-and-when 'sequential-command-config
  (sequential-command-setup-keys))

;;; srep.el
;; excelのオートフィルのような繰り返し
;; https://github.com/kmorimoto/srep
(my-require-and-when 'srep)

;;; key-combo.el ---
;; 特定の文字を連続して入力すると別の文字列に変換
;; https://raw.github.com/uk-ar/key-combo/master/key-combo.el
(my-require-and-when 'key-combo
  (key-combo-define-global (kbd ";") ";")
  (key-combo-define-global (kbd "=") '("=" " = " " == " " === " ))
  (key-combo-define-global (kbd "=>") " => ")
  (key-combo-define-global (kbd ">") '(">" " > "))
  (key-combo-define-global (kbd ">=") " >= ")
  (key-combo-define-global (kbd "<") '("<" " < "))
  (key-combo-define-global (kbd "<=") " <= ")
  (key-combo-define-global (kbd "<>") " <> ")
  ;(key-combo-define-global (kbd "{") "{")
  ;(key-combo-define-global (kbd "{") "{`!!'}")
  ;(key-combo-define-global (kbd "[") '("["))
  ;(key-combo-define-global (kbd "[") "[`!!']")
  (key-combo-define-global (kbd "!") "!")
  (key-combo-define-global (kbd "!=") " != ")
  (key-combo-define-global (kbd "/") '("/" "// ")))

;;; sticky.el ---
;; sticky shiftを実現
;; http://www.emacswiki.org/emacs/sticky.el
(my-require-and-when 'sticky
  (use-sticky-key ?\; sticky-alist:ja))

;;; dont-type-twice.el ---
;; 同じキーを連打するとミニバッファに警告を出してくれます。
;; http://e-arrows.sakura.ne.jp/2010/06/dont-type-twice-el.html
(my-require-and-when 'dont-type-twice
  (global-dont-type-twice t)
  (setq dt2-notify-func 'dt2-message))


;;; drill-instructor.el ---
;; Emacsキーバインド強制elisp
;; http://blog.livedoor.jp/k1LoW/archives/65055608.html
(my-require-and-when 'drill-instructor
  (setq drill-instructor-global t)
  ; 真鬼軍曹.el(失敗したら即終了)
  ;(mapc (lambda (name)
  ;        (fset name 'kill-emacs))
  ;      '(drill-instructor-alert-up
  ;        drill-instructor-alert-down
  ;        drill-instructor-alert-right
  ;        drill-instructor-alert-left
  ;        drill-instructor-alert-del
  ;        drill-instructor-alert-return
  ;        drill-instructor-alert-tab))
  )

;;; dmacro.el ---
;; キー操作の繰返し検出 & 実行
;; http://www.pitecan.com/DynamicMacro/
(my-autoload-and-when 'dmacro-exec "dmacro")

;;; ddskk.el ---
;; Daredevil SKK (DDSKK) は Emacs Lisp 版の SKK です。
;; http://openlab.ring.gr.jp/skk/ddskk-ja.html
;(my-require-and-when 'skk-autoloads
;  (global-set-key "\C-x\C-j" 'skk-mode)
;  (global-set-key "\C-xj" 'skk-auto-fill-mode)
;  (global-set-key "\C-xt" 'skk-tutorial)
;
;  (setq skk-sticky-key ";")
;  (setq skk-show-inline 'vertical)
;  (setq skk-dcomp-multiple-activate t)
;
;  (setq skk-large-jisyo "/Applications/Emacs.app/Contents/Resources/etc/skk/SKK-JISYO.L")
;  (skk-mode t))

;;; sekka.el ---
;; Sekka(石火)はkiyokaが開発中のSKKライクな日本語入力メソッドです。
;; http://oldtype.sumibi.org/show-page/Sekka
;(when (= 0 (shell-command "sekka-path"))
;  (push (concat (car (split-string (shell-command-to-string "sekka-path"))) "/emacs") load-path)
;  (my-require-and-when 'sekka
;    (global-sekka-mode t)))

;;; guide-key
(my-require-and-when 'guide-key
  (setq guide-key/guide-key-sequence t)
  (setq guide-key/highlight-command-regexp "rectangle\\|register\\|org-clock")
  (setq guide-key/idle-delay 1.0)
  (setq guide-key/popup-window-position 'bottom)
  (setq guide-key/text-scale-amount-2)
  (guide-key-mode 1))
