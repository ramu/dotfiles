;================
; autoinsert
;================

(require 'autoinsert)
(add-hook 'find-file-hooks 'auto-insert)
(add-hook 'find-file-not-found-hooks 'auto-insert)

; user-mail-addressのデフォルト値生成に使われる変数にセット
(setq mail-host-address "ramusara@gmail.com")
(setq user-mail-address "ramusara@gmail.com")

; auto-insert-mode有効
(auto-insert-mode t)

; テンプレート挿入時に尋ねない
(setq auto-insert-query nil)

; 各ファイルに応じてテンプレートを切り替える
(setq auto-insert-directory "~/.emacs.d/conf/share/templates/")
(setq auto-insert-alist
  (append '(
    ("\\.c$"         . ["template.c"        my-template])  ;; c
    ("\\.h$"         . ["template.h"        my-template])  ;; c header
    ("\\.cc$"        . ["template.cc"       my-template])  ;; c++
    ("\\.hpp$"       . ["template.hpp"      my-template])  ;; c++ header
    ("test_.*\\.py$" . ["test_template.py"  my-template])  ;; python
    ("\\.py$"        . ["template.py"       my-template])  ;; python
    ("\\.pl$"        . ["template.pl"       my-template])  ;; perl
    ("\\.htm[l]?$"   . ["template.html"     my-template])) ;; html
  auto-insert-alist))

(defun buffer-file-name-nondirectory ()
  (file-name-nondirectory (buffer-file-name)))
(defun python-module-name ()
  (substring (buffer-file-name-nondirectory) 5 -3))
(defun python-test-case-name ()
  (concat "Test" (capitalize (python-module-name))))

; replace
(defvar template-replacements-alists
  '(("%file%"             . (lambda () (file-name-nondirectory (buffer-file-name))))
    ("%name%"             . user-full-name)
    ("%mail%"             . (lambda () (identity user-mail-address)))
    ("%cyear%"            . (lambda () (substring (current-time-string) -4)))
    ("%file-without-ext%" . (lambda () (file-name-sans-extension (file-name-nondirectory (buffer-file-name)))))
    ("%include-guard%"    . (lambda () (format "__SCHEME_%s__" (upcase (file-name-sans-extension (file-name-nondirectory buffer-file-name))))))
    ; python
    ("%testee%"           . (lambda () (python-module-name)))
    ("%test_class%"       . (lambda () (python-test-case-name)))))

(defun my-template ()
  (time-stamp)
  (mapc #' (lambda (c)
            (progn
             (goto-char (point-min))
             (while (re-search-forward (car c) nil t)
               (replace-match (funcall (cdr c))))))
           template-replacements-alists)
  (goto-char (point-max))
  (message "done."))


