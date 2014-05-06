;;;; 01_frame.el
(require '00_common)

(setq initial-frame-alist
  (append (list
           '(foreground-color . "white")  ;; font-color
           '(background-color . "black")  ;; background-color
           '(border-color     . "black")  ;; border-color
           '(mouse-color      . "white")  ;; mouse-color
           '(cursor-color     . "white")  ;; cursor-color
           '(width            . 202    )  ;; frame-width
           '(height           . 62     )  ;; frame-height
           '(top              . 1      )  ;; frame-top(Y)
           '(left             . 1      )  ;; frame-left(X)
           '(alpha            . (85 85))  ;; alpha
          )
  initial-frame-alist))
(setq default-frame-alist initial-frame-alist)
(setq window-min-width 1)

;; full-screen
(set-frame-parameter nil 'fullscreen 'fullscreen)
(defun toggle-fullscreen()
  (interactive)
  (set-frame-parameter nil 'fullscreen (if (frame-parameter nil 'fullscreen) nil 'fullboth)))

;; 透過
(if window-system
    (progn
      (set-background-color "Black")
      (set-foreground-color "LightGray")
      (set-cursor-color "Gray")
      (set-frame-parameter (selected-frame) 'alpha '(85 30))))
;; Set transparency of emacs
(defun transparency (value)
    "Sets the transparency of the frame window. 0=transparent/100=opaque"
    (interactive "nTransparency Value 0 - 100 opaque:")
    (set-frame-parameter (selected-frame) 'alpha value))

;; フレームのタイトル指定
(setq frame-title-format (concat "%b - emacs@" system-name))

;; fringe-mode
;(fringe-mode "left-only")

;;;;; 左側に行数表示
;(my-require-and-when 'linum
;  (setq linum-format "%5d ")
;  (defvar mylinum-mode-name nil)
;  (setq mylinum-mode-name '(emacs-lisp-mode-hook slime-mode-hook sh-mode-hook text-mode-hook
;                             php-mode-hook python-mode-hook ruby-mode-hook
;                             css-mode-hook yaml-mode-hook org-mode-hook
;                             howm-mode-hook js2-mode-hook javascript-mode-hook
;                             smarty-mode-hook html-helper-mode-hook))
;  (mapc (lambda (hook-name) (add-hook hook-name (lambda () (linum-mode t)))) mylinum-mode-name))

;; scrollbarは不要
(toggle-scroll-bar 0)

;;;;; 左側に行数表示(line-num.el) ---> 現在位置も分かる拡張版(yalinum.el)
;;;;; 相性問題？不安定なので使用中止
;(require 'yalinum)
;(setq yalinum-line-number-display-format "%5d")
;
;(dolist (hook (list
;               'c-mode-common-hook
; yalinum+anything+popwinの相性が悪い。開けなくなる
;  ---> 下記二つに関しては表示しない
;               'emacs-lisp-mode-hook
;               'lisp-interaction-mode-hook
;               'lisp-mode-hook
;               'java-mode-hook
;               'haskell-mode-hook
;               'sh-mode-hook
;               'cperl-mode-hook
;               'python-mode-hook
;               'ess-mode-hook
;               'inferior-ess-mode-hook
;               'lua-mode-hook
;               'html-mode-hook
;               'scala-mode-hook))
;  (add-hook hook '(lambda ()
;                   (yalinum-mode 1))))
;(global-yalinum-mode t)
;;yalinum色設定
;(set-face-background 'yalinum-face "#000000")
;(set-face-foreground 'yalinum-face "#009900")
;(set-face-background 'yalinum-bar-face "#003300")
;(set-face-foreground 'yalinum-bar-face "#00FF00")

;; モードライン
(setq-default mode-line-format
              '("-"
                mode-line-mule-info
                mode-line-modified
                mode-line-frame-identification
                mode-line-buffer-identification
                " "
                global-mode-string
                " %[("
                mode-name
                mode-line-process
                minor-mode-alist
                "%n" ")%]-"
                (which-func-mode ("" which-func-format "-"))
                (line-number-mode "L%l-")
                (column-number-mode "C%c-")
                (-3 . "%p")
                "-%-"))

; モードラインの表示文字を短縮表示(http://d.hatena.ne.jp/syohex/20130131/1359646452)
(defvar mode-line-cleaner-alist
  '(;; minor-mode
    (my-mode . " my")
    (lisp-mode . " el")
    (lisp-interaction-mode . " li")
    (paredit-mode . " pe")
    (ruby-block-mode . " rb")
    (drill-instructor . " d")
    (undo-tree-mode . " ut")
    (flymake-mode . " fm")
    (git-gutter+-mode . " gg")
    ;; Major mode
    (fundamental-mode . "F")
    (emacs-lisp-mode . "El")
    (python-mode . "PY")
    (ruby-mode . "RB")))

(defun clean-mode-line ()
  (interactive)
  (loop for (mode . mode-str) in mode-line-cleaner-alist
        do
        (let ((old-mode-str (cdr (assq mode minor-mode-alist))))
          (when old-mode-str
            (setcar old-mode-str mode-str))
          (when (eq mode major-mode)
            (setq mode-name mode-str)))))
(add-hook 'after-change-major-mode-hook 'clean-mode-line)

;; toggle transparency
(defun toggle-transparency ()
  (interactive)
  (if (/=
       (cadr (frame-parameter nil 'alpha))
        100)
       (set-frame-parameter nil 'alpha '(40 100))
     (set-frame-parameter nil 'alpha '(85 85))))

; C-tはC-o(other-window)にする。ただ空の時は新たに作ってほしいので下記を利用
;  other-window-or-split @rubikitch
;(defun other-window-or-split ()
;  (interactive)
;  (when (one-window-p)
;    (split-window-horizontally))
;  (other-window 1))
