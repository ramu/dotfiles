;;; 10_shell-pop.el --- 
(require 'shell-pop)
(shell-pop-set-internal-mode "ansi-term")
(shell-pop-set-internal-mode-shell "/bin/zsh")
(shell-pop-set-window-height 60) ;the number for the percentage of the selected window. if 100, shell-pop use the whole of selected window, not spliting.
(shell-pop-set-window-position "bottom") ;shell-pop-up position. You can choose "top" or "bottom". 
(global-set-key (kbd "C-c t") 'shell-pop)

