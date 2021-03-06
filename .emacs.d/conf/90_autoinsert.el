;;;; 90_autoinsert.el
(require '00_common)

(my-require-and-when 'autoinsert
  (add-hook 'find-file-hooks 'auto-insert)
  (add-hook 'find-file-not-found-hooks 'auto-insert)

  ;; user-mail-addressのデフォルト値生成に使われる変数にセット
  (setq mail-host-address "ramusara@gmail.com")
  (setq user-mail-address "ramusara@gmail.com")

  (auto-insert-mode t)          ; auto-insert-mode有効
  (setq auto-insert-query nil)  ; テンプレート挿入時に尋ねない

  ; 各ファイルに応じてテンプレートを切り替える
  (setq auto-insert-directory "~/.emacs.d/share/templates/")
  (setq auto-insert-alist
    (append '(
      ("\\.c$"         . ["template.c"        my-template])  ;; c
      ("\\.h$"         . ["template.h"        my-template])  ;; c header
      ("\\.cc$"        . ["template.cc"       my-template])  ;; c++
      ("\\.hpp$"       . ["template.hpp"      my-template])  ;; c++ header
      ("test_.*\\.py$" . ["test_template.py"  my-template])  ;; python
      ("\\.py$"        . ["template.py"       my-template])  ;; python
      ("\\.pl$"        . ["template.pl"       my-template])  ;; perl
      ("test_.*\\.rb$" . ["test_template.rb"  my-template])  ;; Ruby
      ("\\.rb$"        . ["template.rb"       my-template])  ;; Ruby
      ("\\.htm[l]?$"   . ["template.html"     my-template])) ;; html
    auto-insert-alist))

  (defun buffer-file-name-nondirectory ()
    (file-name-nondirectory (buffer-file-name)))
  (defun test-module-name ()
    (substring (buffer-file-name-nondirectory) 5 -3))
  (defun test-class-name ()
    (concat "Test" (capitalize (test-module-name))))

  ;; replace
  (defvar template-replacements-alists
    '(("%file%"                 . (lambda () (file-name-nondirectory (buffer-file-name))))
      ("%name%"                 . user-full-name)
      ("%mail%"                 . (lambda () (identity user-mail-address)))
      ("%cyear%"                . (lambda () (substring (current-time-string) -4)))
      ("%file-without-ext%"     . (lambda () (file-name-sans-extension (file-name-nondirectory (buffer-file-name)))))
      ("%cap-file-without-ext%" . (lambda () (capitalize (file-name-sans-extension (file-name-nondirectory (buffer-file-name))))))
      ("%include-guard%"        . (lambda () (format "__SCHEME_%s__" (upcase (file-name-sans-extension (file-name-nondirectory buffer-file-name))))))
      ("%testee%"               . (lambda () (test-module-name)))
      ("%cap-testee%"           . (lambda () (capitalize (test-module-name))))
      ("%test_class%"           . (lambda () (test-class-name)))
      ("%rbclass%"              . (lambda () (replace-regexp-in-string "_" "" (capitalize (file-name-sans-extension (file-name-nondirectory (buffer-file-name)))))))))

  (defun my-template ()
    (time-stamp)
    (mapc #' (lambda (c)
              (progn (goto-char (point-min))
                     (while (re-search-forward (car c) nil t)
                       (replace-match (funcall (cdr c))))))
             template-replacements-alists)
    (goto-char (point-max))
    (message "done.")))
