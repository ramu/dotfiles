;;; 10_flymake-shell.el ---
(require 'flymake-shell)
(add-hook 'sh-mode-hook 'flymake-shell-load)

