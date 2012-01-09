;;;; 90_input.el ---


;;; smartrep.el
;; 連続操作の省力化
;; http://sheephead.homelinux.org/2011/12/19/6930/
(require 'smartrep)
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
                    ("B" . (lambda () (end-of-buffer-other-window 0)))))


;;; srep.el
;; excelのオートフィルのような繰り返し
;; https://github.com/kmorimoto/srep
(require 'srep)


;;; sequential-config.el
;; 同じコマンドを連続実行することで挙動を変える（行頭→先頭など）
;; http://d.hatena.ne.jp/rubikitch/20090219/sequential_command
(require 'sequential-command-config)
(sequential-command-setup-keys)


;;; key-combo.el ---
;; 特定の文字を連続して入力すると別の文字列に変換
;; https://raw.github.com/uk-ar/key-combo/master/key-combo.el
(require 'key-combo)
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
(key-combo-define-global (kbd "/") '("/" "// "))


;;; sticky.el ---
;; sticky shiftを実現
;; http://www.emacswiki.org/emacs/sticky.el
(require 'sticky)
(use-sticky-key ?\; sticky-alist:ja)


;;; dont-type-twice.el ---
;; 同じキーを連打するとミニバッファに警告を出してくれます。
;; http://e-arrows.sakura.ne.jp/2010/06/dont-type-twice-el.html
(require 'dont-type-twice)
(global-dont-type-twice t)
(setq dt2-notify-func 'dt2-growl)   ; Growlで表示


;;; drill-instructor.el ---
;; Emacsキーバインド強制elisp
;; http://blog.livedoor.jp/k1LoW/archives/65055608.html
(require 'drill-instructor)
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


;;; dmacro.el ---
;; キー操作の繰返し検出 & 実行
;; http://www.pitecan.com/DynamicMacro/
(autoload 'dmacro-exec "dmacro" t nil)


;;; ddskk.el ---
;; Daredevil SKK (DDSKK) は Emacs Lisp 版の SKK です。
;; http://openlab.ring.gr.jp/skk/ddskk-ja.html
;(require 'skk-autoloads)
;(global-set-key "\C-x\C-j" 'skk-mode)
;(global-set-key "\C-xj" 'skk-auto-fill-mode)
;(global-set-key "\C-xt" 'skk-tutorial)

;(setq skk-sticky-key ";")
;(setq skk-show-inline 'vertical)
;(setq skk-dcomp-multiple-activate t)

;(setq skk-large-jisyo "/Applications/Emacs.app/Contents/Resources/etc/skk/SKK-JISYO.L")
;(skk-mode)


;;; sekka.el ---
;; Sekka(石火)はkiyokaが開発中のSKKライクな日本語入力メソッドです。
;; http://oldtype.sumibi.org/show-page/Sekka
;(when (= 0 (shell-command "sekka-path"))
;  (push (concat (car (split-string (shell-command-to-string "sekka-path"))) "/emacs") load-path)
;  (require 'sekka)
;  (global-sekka-mode 1))


;;; one-key.el
(require 'one-key)
(require 'one-key-config)
(define-key global-map "\C-xr" 'one-key-menu-Register-and-Rectangle)
;; one-key menu for Register and Rectangle
(defvar one-key-menu-Register-and-Rectangle-alist nil
  "The `one-key' menu alist for Register and Rectangle.")
(setq one-key-menu-Register-and-Rectangle-alist
      '(
	(("C-@" . "Point To Register (C-@)") . point-to-register)
	(("SPC" . "Point To Register (SPC)") . point-to-register)
	(("+" . "Increment Register (+)") . increment-register)
	(("b" . "Bookmark Jump (b)") . bookmark-jump)
	(("c" . "Clear Rectangle (c)") . clear-rectangle)
	(("d" . "Delete Rectangle (d)") . delete-rectangle)
	(("f" . "Frame Configuration To Register (f)") . frame-configuration-to-register)
	(("g" . "Insert Register (g)") . insert-register)
	(("i" . "Insert Register (i)") . insert-register)
	(("j" . "Jump To Register (j)") . jump-to-register)
	(("k" . "Kill Rectangle (k)") . kill-rectangle)
	(("l" . "Bookmark Bmenu List (l)") . bookmark-bmenu-list)
	(("m" . "Bookmark Set (m)") . bookmark-set)
	(("n" . "Number To Register (n)") . number-to-register)
	(("o" . "Open Rectangle (o)") . open-rectangle)
	(("r" . "Copy Rectangle To Register (r)") . copy-rectangle-to-register)
	(("s" . "Copy To Register (s)") . copy-to-register)
	(("t" . "String Rectangle (t)") . string-rectangle)
	(("w" . "Window Configuration To Register (w)") . window-configuration-to-register)
	(("x" . "Copy To Register (x)") . copy-to-register)
	(("y" . "Yank Rectangle (y)") . yank-rectangle)
	(("C-SPC" . "Point To Register (C-SPC)") . point-to-register)
	))
(defun one-key-menu-Register-and-Rectangle ()
  "The `one-key' menu for Register and Rectangle"
  (interactive)
  (one-key-menu "Register and Rectangle" one-key-menu-Register-and-Rectangle-alist))
;; Use the `one-key-get-menu' command to show menu/keybindings for this buffer.
;; Uncomment and edit following line to set this menu as default for mode.
;;(add-to-list 'one-key-mode-alist '(C-x r . one-key-menu-Register-and-Rectangle))
;; Uncomment and edit following line to add this menu to toplevel menu.
;;(add-to-list 'one-key-toplevel-alist '(("type key here" . "Register and Rectangle") . one-key-menu-Register-and-Rectangle))
(require 'one-key-default)
;(one-key-default-setup-keys)

