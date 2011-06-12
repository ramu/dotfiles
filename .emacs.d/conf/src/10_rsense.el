;;; 10_rsense.el --- 
(require 'rsense)
(setq rsense-home "/opt/rsense-0.3")

(add-hook 'ruby-mode-hook
          (lambda ()
            (add-to-list 'ac-sources 'ac-source-rsense-method)
            (add-to-list 'ac-sources 'ac-source-rsense-constant)))

