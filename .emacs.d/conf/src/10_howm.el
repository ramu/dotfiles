;;; 10_howm.el ---
(setq howm-menu-lang 'ja)

(global-set-key "\C-c,," 'howm-menu)
(setq howm-directory "~/Dropbox/files/howm/")
(setq howm-file-name-format "%Y-%m-%d.howm")

(mapc
 (lambda (f)
   (autoload f "howm" "Hitori Otegaru Wiki Modoki" t))
 '(howm-menu howm-list-all howm-list-recent
             howm-list-grep howm-create
             howm-keyword-to-kill-ring))

