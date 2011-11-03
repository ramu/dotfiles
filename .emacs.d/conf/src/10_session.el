;;; 10_session.el ---
(require 'session)

(setq session-initialize '(de-saveplace session keys menus places)
      session-globals-include '((kill-ring 50)
                                (session-file-alist 500 t)
                                (file-name-history 10000)))

(setq session-globals-max-string 100000000)
(setq history-length t)
(setq session-save-file (expand-file-name "./.emacs.d/var/.session"))

(add-hook 'after-init-hook 'session-initialize)

