;;; 10_one-key.el --- 
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

