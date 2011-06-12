;; 10_auto-install.el
(require 'auto-install)
(add-to-list 'load-path auto-install-directory)
(setq auto-install-directory "~/.emacs.d/elisp/src/")

(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

