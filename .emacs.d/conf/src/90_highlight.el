;===========================================
; 現在カーソルのある行をハイライト表示する 
;===========================================
(require 'hl-line)
(defface my-hlline-face
  '((((class color) (background dark))
;    (:background "dark slate gray" t))
    (:background "#333" t))
   (((class color) (background light))
    (:background "ForestGreen"))
    (t (:bold t)))
  "*Face used by hi-ilne." :group 'hoge)
(setq hl-line-face 'my-hlline-face)
(global-hl-line-mode t)


;===========================================
; 全角スペース、タブに色付け
;===========================================
(defface my-face-b-1 '((t (:background "NavajoWhite4"))) nil :group 'my-faces)
;(defface my-face-b-1 '((t (:background "dark turquois"))) nil :group 'my-faces)
(defface my-face-b-2 '((t (:background "gray10"))) nil :group 'my-faces)
;(defface my-face-b-2 '((t (:background "SeaGreen"))) nil :group 'my-faces)
(defface my-face-u-1 '((t (:foreground "SteelBlue" :underline t))) nil :group 'my-faces)
(defvar my-face-b-1 'my-face-b-1)
(defvar my-face-b-2 'my-face-b-2)
(defvar my-face-u-1 'my-face-u-1)
(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
    major-mode
      '(
        ("　" 0 my-face-b-1 append)
        ("\t" 0 my-face-b-2 append)
        ("[ \t]+$" 0 my-face-u-1 append)
  )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)
(add-hook 'find-file-hooks
          '(lambda ()
             (if font-lock-mode
                 nil
               (font-lock-mode t))))

;===========================================
; カーソルを虹色表示 
;===========================================
;; blink cursor
(require 'cl)
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
