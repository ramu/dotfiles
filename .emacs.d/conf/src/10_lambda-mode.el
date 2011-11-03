;;; 10_lambda-mode.el ---
(require 'lambda-mode)

(add-hook 'python-mode-hook 'lambda-mode t)
(setq lambda-symbol (string (make-char 'greek-iso8859-7 107)))
