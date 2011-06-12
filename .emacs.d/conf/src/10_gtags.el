;; 10_gtags.el
(autoload 'gtags-mode "gtags" "" t)
(require 'gtags)
(add-hook 'c-mode-common-hook 'gtags-mode)
(add-hook 'c++-mode-hook 'gtags-mode)
(add-hook 'java-mode-hook 'gtags-mode)

