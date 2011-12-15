;;;; 04_package.el

;;; auto-install.el
;; EmacsLispパッケージを自動インストール
;; http://d.hatena.ne.jp/rubikitch/20091221/autoinstall
(require 'auto-install)
(add-to-list 'load-path auto-install-directory)
(setq auto-install-directory "~/.emacs.d/elisp/src/")
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;;; install-elisp.el
;; Simple Emacs Lisp installer
;; http://www.emacswiki.org/emacs/install-elisp.el
(require 'install-elisp)
(setq install-elisp-repository-directory "~/.emacs.d/elisp/src/")

