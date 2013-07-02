;;;; 04_package.el
(require '00_common)

;;; auto-install.el
;; EmacsLispパッケージを自動インストール
;; http://d.hatena.ne.jp/rubikitch/20091221/autoinstall
(my-require-and-when 'auto-install
  (add-to-list 'load-path auto-install-directory)
  (setq auto-install-directory "~/.emacs.d/elisp/src/")
  (auto-install-update-emacswiki-package-name t)
  (auto-install-compatibility-setup)
  (setq ediff-window-setup-function 'ediff-setup-windows-plain))

;;; install-elisp.el
;; Simple Emacs Lisp installer
;; http://www.emacswiki.org/emacs/install-elisp.el
(my-require-and-when 'install-elisp
  (setq install-elisp-repository-directory "~/.emacs.d/elisp/src/"))

;;; emacs-bundle.el
;; emacs bundle
;; http://kozo2.hatenablog.com/entry/2011/12/31/184442
(my-load-and-when "~/.emacs.d/elisp/bundle.elc"
  (setq bundle-install-directory (expand-file-name "~/.emacs.d/elisp/src/bundle/")))

;;; package/melpa
(my-require-and-when 'package
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
  (package-initialize)

  (my-require-and-when 'melpa))

