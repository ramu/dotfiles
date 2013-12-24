(require 'cl)

;; elisps
(add-to-list 'load-path "~/.emacs.d/")

;; init-module
(require 'init-module)

;; init-loader
(require 'init-loader)
(setq init-loader-show-log-after-init nil)
(init-loader-load "~/.emacs.d/conf")
