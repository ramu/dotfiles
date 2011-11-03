;;; 03_ddskk.el ---
(require 'skk-autoloads)
(global-set-key "\C-x\C-j" 'skk-mode)
(global-set-key "\C-xj" 'skk-auto-fill-mode)
(global-set-key "\C-xt" 'skk-tutorial)

(setq skk-sticky-key ";")
(setq skk-show-inline 'vertical)
(setq skk-dcomp-multiple-activate t)

(setq skk-large-jisyo "/Applications/Emacs.app/Contents/Resources/etc/skk/SKK-JISYO.L")
(skk-mode)
