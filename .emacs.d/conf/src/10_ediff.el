;;; 10_ediff.el ---
(require 'ediff)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq-default ediff-auto-refine-limit 10000)

;;ediff関連のバッファを一つのフレームにまとめる
;(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; 縦分割
(setq ediff-split-window-function 'split-window-horizontally)

(add-hook 'ediff-mode-hook
          (lambda ()
            ;; diff-A(left)
            ;; 選択
            (set-face-foreground ediff-current-diff-face-A "black")
            (set-face-background ediff-current-diff-face-A "#FF6600")
            (set-face-foreground ediff-current-diff-face-B "black")
            (set-face-background ediff-current-diff-face-B "#FF6600")
            (set-face-foreground ediff-current-diff-face-C "black")
            (set-face-background ediff-current-diff-face-C "#FF6600")
            (make-face-bold-italic ediff-current-diff-face-A)
            (make-face-bold-italic ediff-current-diff-face-B)
            (make-face-bold-italic ediff-current-diff-face-C)
            ;; 差分(選択時)
            (set-face-foreground ediff-fine-diff-face-A "black")
            (set-face-background ediff-fine-diff-face-A "#99FF00")
            (set-face-foreground ediff-fine-diff-face-B "black")
            (set-face-background ediff-fine-diff-face-B "#99FF00")
            (set-face-foreground ediff-fine-diff-face-C "black")
            (set-face-background ediff-fine-diff-face-C "#99FF00")
            ;; 追加
            (set-face-foreground ediff-even-diff-face-A "black")
            (set-face-background ediff-even-diff-face-A "#FF9900")
            (set-face-foreground ediff-even-diff-face-B "black")
            (set-face-background ediff-even-diff-face-B "#FF9900")
            (set-face-foreground ediff-even-diff-face-C "black")
            (set-face-background ediff-even-diff-face-C "#FF9900")
            ;; 未選択
            (set-face-foreground ediff-odd-diff-face-A "black")
            (set-face-background ediff-odd-diff-face-A "#FF9900")
            (set-face-foreground ediff-odd-diff-face-B "black")
            (set-face-background ediff-odd-diff-face-B "#FF9900")
            (set-face-foreground ediff-odd-diff-face-C "black")
            (set-face-background ediff-odd-diff-face-C "#FF9900")))
