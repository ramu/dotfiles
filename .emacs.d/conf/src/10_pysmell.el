;;; 10_pysmell.el --- 
(require 'pysmell)

;; auto-complete.elから呼べるように編集
(defvar ac-source-pysmell
  '((candidates
     . (lambda ()
         (pysmell-get-all-completions))))
  "Source for PySmell")

(add-hook 'python-mode-hook
          '(lambda ()
             (pysmell-mode t)
             (set (make-local-variable 'ac-sources) (append ac-sources '(ac-source-pysmell)))))
