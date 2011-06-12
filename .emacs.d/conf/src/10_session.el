;;; 10_session.el --- 
(when (require 'session nil t)
(setq session-initialize '(de-saveplace session keys menus places)
      session-globals-include '((kill-ring 50)
                                (session-file-alist 500 t)
                                (file-name-history 10000)))

(setq session-globals-max-string 100000000)
(setq history-length t)
(add-hook 'after-init-hook 'session-initialize))

