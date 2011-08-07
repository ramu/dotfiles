;; 01_frame.el
(setq initial-frame-alist
  (append (list
           '(foreground-color . "white")  ;; font-color
           '(background-color . "black")  ;; background-color
           '(border-color     . "black")  ;; border-color
           '(mouse-color      . "white")  ;; mouse-color
           '(cursor-color     . "white")  ;; cursor-color
           '(width            . 220    )  ;; frame-width
           '(height           . 90     )  ;; frame-height
           '(top              . 1      )  ;; frame-top(Y)
           '(left             . 1      )  ;; frame-left(X)
           '(alpha            . (85 85))  ;; alpha
          )
  initial-frame-alist))
(setq default-frame-alist initial-frame-alist)
(setq window-min-width 1)

;; 透過
(if window-system (progn
    (set-background-color "Black")
    (set-foreground-color "LightGray")
    (set-cursor-color "Gray")
    (set-frame-parameter (selected-frame) 'alpha '(85 30))
))
;; Set transparency of emacs
(defun transparency (value)
    "Sets the transparency of the frame window. 0=transparent/100=opaque"
    (interactive "nTransparency Value 0 - 100 opaque:")
    (set-frame-parameter (selected-frame) 'alpha value))

;; フレームのタイトル指定
(setq frame-title-format (concat "%b - emacs@" system-name))

;;;;; 左側に行数表示
(require 'linum)
(setq linum-format "%5d ")
(defvar mylinum-mode-name nil)
(setq mylinum-mode-name '(emacs-lisp-mode-hook slime-mode-hook sh-mode-hook text-mode-hook
                           php-mode-hook python-mode-hook ruby-mode-hook
                           css-mode-hook yaml-mode-hook org-mode-hook
                           howm-mode-hook js2-mode-hook javascript-mode-hook
                           smarty-mode-hook html-helper-mode-hook))
(mapc (lambda (hook-name) (add-hook hook-name (lambda () (linum-mode t)))) mylinum-mode-name)

;;;;; 左側に行数表示(line-num.el) ---> 現在位置も分かる拡張版(yalinum.el)
;;;;; 相性問題？不安定なので使用中止
;; scrollbarは不要(yalinumで対応)
(toggle-scroll-bar nil)
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
