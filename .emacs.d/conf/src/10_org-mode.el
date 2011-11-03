;;; 10_org-mode.el ---
(require 'org)

; Emacs technic bible(P.275)
(defun org-insert-upheading (arg)
  "1レベル上の見出しを入力する。"
  (interactive "P")
  (org-insert-heading arg)
  (cond ((org-on-heading-p) (org-do-promote))
        ((org-at-item-p)    (org-indent-item -1))))
(defun org-insert-heading-dwim (arg)
  "現在と同じレベルの見出しを入力する。
   C-uをつけると1レベル上、C-u C-uをつけると1レベル下の見出しを入力する。"
  (interactive "p")
  (case arg
    (4  (org-insert-subheading nil))
    (16 (org-insert-upheading  nil))
    (t  (org-insert-heading    nil))))
(define-key org-mode-map (kbd "<C-M-S-return>") 'org-insert-heading-dwim)

; Emacs technic bible(P.277)
(org-remember-insinuate)
(setq org-directory "/Users/ramusara/memo/")
(setq org-default-notes-file (expand-file-name "memo.org" org-directory))
(setq org-remember-templates
      '(("Note" ?n "** %?\n   %i\n   %a\n   %t" nil "Inbox")
        ("Todo" ?t "** TODO %?\n   %i\n   %a\n   %t" nil "Inbox")))


; keybind
(define-key org-mode-map (kbd "M-p") 'org-metaup)
(define-key org-mode-map (kbd "M-n") 'org-metadown)
