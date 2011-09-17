;;; 10_ruby-block.el ---
(require 'ruby-block)
(add-hook 'ruby-mode-hook
          '(lambda ()
             (ruby-block-mode t)
             (ruby-block-highlight-toggle t)))

(setq ruby-block-delay 0)

;; 何もしない
;(setq ruby-block-highlight-toggle 'noghing)
;; ミニバッファに表示
;(setq ruby-block-highlight-toggle 'minibuffer)
;; オーバレイする
;(setq ruby-block-highlight-toggle 'overlay)
;; ミニバッファに表示し, かつ, オーバレイする.
;(setq ruby-block-highlight-toggle t)
