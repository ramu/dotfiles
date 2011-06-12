;; 10_sdic.el
;;(require 'sdic)

(autoload 'sdic-describe-word "sdic" "英単語辞書" t nil)
(global-set-key (kbd "C-c w") 'sdic-describe-word)
(autoload 'sdic-describe-word-at-point "sdic" "英単語辞書(カーソル位置)" t nil)
(global-set-key (kbd "C-c W") 'sdic-describe-word-at-point)

(setq sdic-eiwa-dictionary-list '((sdicf-client "/usr/local/share/dict/gene.sdic")))
(setq sdic-waei-dictionary-list '((sdicf-client "/usr/local/share/dict/jedict.sdic")))
;;(setq sdic-default-coding-system 'utf-8-unix)
