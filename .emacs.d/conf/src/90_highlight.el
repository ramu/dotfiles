;;;; 90_highlight.el ---
(require '00_common)

;; カーソル点滅
(blink-cursor-mode t)
(setq blink-cursor-interval 0.7)

;; 対応する括弧を光らせる(グラフィック環境のみ)
(show-paren-mode t)
(setq show-paren-style 'expression)
(set-face-background 'show-paren-match-face "#222277")
;(set-face-underline-p 'show-paren-match-face "lightblue")

;; 行末の空白表示
(setq-default show-trailing-whitespace t)
(add-hook 'term-mode-hook '(lambda ()
                             (setq show-trailing-whitespace nil)))

;; region high-light
(setq transient-mark-mode t)

;; region color
(set-face-background 'region "#3333BB")

;; 色々なファイルの色付け
(my-require-and-when 'generic-x)

; カーソル上のシンボル自動ハイライト
(my-require-and-when 'auto-highlight-symbol
  (global-auto-highlight-symbol-mode t)
  (ahs-set-idle-interval 0.5))

;;; highlight-indentation.el
;; function made to show vertical guide lines of indentation levels (spaces only).
;; http://www.emacswiki.org/emacs/HighlightIndentation
(my-require-and-when 'highlight-indentation
  (setq highlight-indent-active t))

;;; 現在カーソルのある行をハイライト表示する
(my-require-and-when 'hl-line+
  (defface my-hlline-face
    '((((class color) (background dark))
      (:background "#226688" t))
     (((class color) (background light))
      (:background "ForestGreen"))
      (t (:bold t)))
    "*Face used by hi-ilne." :group 'hoge)
  (setq hl-line-face 'my-hlline-face)
  (add-hook 'term-mode-hook '(lambda ()
                               (set (make-local-variable 'hl-line-range-function)
                                    (lambda ()
                                      '(0 . 0)))))
  (global-hl-line-mode t))

;;; 全角スペース、タブに色付け
(defface my-face-b-1 '((t (:background "NavajoWhite4"))) nil :group 'my-faces)
;(defface my-face-b-1 '((t (:background "dark turquois"))) nil :group 'my-faces)
(defface my-face-b-2 '((t (:background "gray10"))) nil :group 'my-faces)
;(defface my-face-b-2 '((t (:background "SeaGreen"))) nil :group 'my-faces)
(defface my-face-u-1 '((t (:foreground "SteelBlue" :underline t))) nil :group 'my-faces)
(defvar my-face-b-1 'my-face-b-1)
(defvar my-face-b-2 'my-face-b-2)
(defvar my-face-u-1 'my-face-u-1)
(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords major-mode
      '(("　" 0 my-face-b-1 append)
        ("\t" 0 my-face-b-2 append)
        ("[ \t]+$" 0 my-face-u-1 append))))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)
(add-hook 'find-file-hooks '(lambda ()
                              (if font-lock-mode
                                  nil
                                (font-lock-mode t))))


;;; blank-mode.el
(my-require-and-when 'blank-mode
  (setq blank-space-regexp "\\(　+\\)")
  (set-face-background 'blank-space "#000000")
  (set-face-background 'blank-newline "#000000")
  (defface blank-space
    '((((class color)(background dark))
       (:background "grey20"      :foreground "aquamarine3"))
      (((class color)(background light))
       (:background "LightYellow" :foreground "aquamarine3"))
      (t (:inverse-video t)))
    "Face used to visualize SPACE."
    :group 'blank))

;;; blink cursor
;; カーソルを虹色表示
(lexical-let ((interval 1)
              (colors '("red" "green" "blue" "yellow" "purple" "magenta" "cyan"))
              (cursor-nth 0)
              (timer nil))
  (defun cute-cursor (flag)
    "Start toggling cursor color when flag is true."
    (cond
     ((and flag timer) (cute-cursor nil))
     (flag (setq timer (run-with-timer interval interval
                         (lambda ()
                            (set-cursor-color (nth cursor-nth colors))
                            (incf cursor-nth)
                            (if (>= cursor-nth (length colors))
                              (setq cursor-nth 0)))))
           (blink-cursor-mode 0))
     (timer (cancel-timer timer)
            (setq timer nil)))))
(cute-cursor t)

;;; rainbow-delimiters.el
(my-require-and-when 'rainbow-delimiters
  (add-hook 'scheme-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'shell-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
  ;; colors
  (set-face-foreground 'rainbow-delimiters-depth-1-face  "#FF5555")  ; Red
  (set-face-foreground 'rainbow-delimiters-depth-2-face  "#55FF55")  ; Green
  (set-face-foreground 'rainbow-delimiters-depth-3-face  "#5555FF")  ; Blue
  (set-face-foreground 'rainbow-delimiters-depth-4-face  "#CCCCCC")  ; Grey
  (set-face-foreground 'rainbow-delimiters-depth-5-face  "#FFFF55")  ; Yellow
  (set-face-foreground 'rainbow-delimiters-depth-6-face  "#FF55FF")  ; Purple
  (set-face-foreground 'rainbow-delimiters-depth-7-face  "#55FFFF")  ; light-blue
  (set-face-foreground 'rainbow-delimiters-depth-8-face  "#AAAAAA")  ; Grey...
  (set-face-foreground 'rainbow-delimiters-depth-9-face  "#888888")  ; Grey....
  ;test -> (((((((((((())))))))))))
  )

;;; rainbow-mode.el
(my-require-and-when 'rainbow-mode
  (add-hook 'html-mode-hook 'rainbow-mode)
  (add-hook 'css-mode-hook 'rainbow-mode)
  (add-hook 'scss-mode-hook 'rainbow-mode)
  (add-hook 'php-mode-hook 'rainbow-mode)
  (add-hook 'css-mode-hook 'rainbow-mode))
