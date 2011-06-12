;; elisps
(add-to-list 'load-path "~/.emacs.d/elisp")

;; init-loader
(require 'init-loader)
(setq init-loader-show-log-after-init nil)
(init-loader-load "~/.emacs.d/conf")
