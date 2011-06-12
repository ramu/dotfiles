;;; 10_phpdoc.el --- 
(require 'phpdoc)
(add-hook 'php-mode-hook (lambda () (eldoc-mode t)))
