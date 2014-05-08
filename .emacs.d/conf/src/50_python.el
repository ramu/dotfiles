;;; 50_python.el ---
(require '00_common)

(my-require-and-when 'python
  (my-require-and-when 'python-lite)

  (defun python-lite:setup ()
    (let ((key-map '(("\C-c\C-@" . python-lite:eval/compile)
                     ("\C-c\C-u" . python-lite:insert-module)
                     ("\M-p"     . python-lite:pydoc)
                     ("\C-x \""  . python-lite:webhelp)
                     )))
      (loop for (k . fun) in key-map
            do (define-key python-mode-map k fun))))

  ;; python-mode
  (my-require-and-when 'python-mode
    (add-auto-mode 'python-mode "\\.py$")
    (setq interpreter-mode-alist (cons '("python" . python-mode) interpreter-mode-alist))
    (autoload 'python-mode "python-mode" "Python editing mode." t)

    (add-hook 'python-mode-hook
              '(lambda()
                    (unless (eq buffer-file-name nil) (flymake-mode t))
                    (python-lite:setup)
                    (flymake-mode t)
                    (hs-minor-mode t)
                    ;;; python-lite:setup
                    (define-key python-mode-map (kbd "C-c C-@") 'python-lite:eval/compile)
                    (define-key python-mode-map (kbd "C-c C-u") 'python-lite:insert-module)
                    (define-key python-mode-map (kbd "M-p")     'python-lite:pydoc)
                    (define-key python-mode-map (kbd "C-x \"")  'python-lite:webhelp)
                    ;;; indent
                    (setq indent-tabs-mode nil)
                    (setq indent-level 4)
                    (setq python-indent 4)
                    (setq tab-width 4))))

  ;; check PEP8
  (defun flymake-pep8-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "pep8" (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pep8-init))

  ;;; ipython
  (my-require-and-when 'ipython
    (setq ipython-command "/opt/local/bin/ipython"))

  ;;; pysmell
  (my-require-and-when 'pysmell
    ; auto-complete.elから呼べるように編集
    (defvar ac-source-pysmell '((candidates . (lambda () (pysmell-get-all-completions)))) "Source for PySmell")
    (add-hook 'python-mode-hook
              '(lambda ()
                 (pysmell-mode t)
                 (set (make-local-variable 'ac-sources) (append ac-sources '(ac-source-pysmell))))))

  ;;; pymacs
  (my-require-and-when 'pymacs
    (autoload 'pymacs-apply "pymacs")
    (autoload 'pymacs-call "pymacs")
    (autoload 'pymacs-eval "pymacs" nil t)
    (autoload 'pymacs-exec "pymacs" nil t)
    (autoload 'pymacs-load "pymacs" nil t)
    (eval-after-load "pymacs"
      '(add-to-list 'pymacs-load-path "~/.emacs.d/share/plugins/python/"))))

