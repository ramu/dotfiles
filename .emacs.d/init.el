(require 'cl)

(setq user-emacs-directory "~/.emacs.d/")

;; elisps
(add-to-list 'load-path "~/.emacs.d/conf/init/")

;; init-module
(require 'init-module)

;; init-loader
(require 'init-loader)
(setq init-loader-show-log-after-init nil)
(init-loader-load "~/.emacs.d/conf/")
