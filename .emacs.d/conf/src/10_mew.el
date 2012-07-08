;;; 10_mew.el ---
(require '00_common)

(my-autoload-and-when 'mew "mew"
  (my-autoload-and-when 'mew-send "mew-send")

  (load "~/.emacs.d/private/.mew.el")
  (setq mew-ssl-verify-level 0)
  (setq mew-use-unread-mark t) ;; U:unread mark

  ;; Optional setup (Read Mail menu for Emacs 21):
  (if (boundp 'read-mail-command)
      (setq read-mail-command 'mew))

  ;; Optional setup (e.g. C-xm for sending a message):
  (my-autoload-and-when 'mew-user-agent-compose "mew"
    (if (boundp 'mail-user-agent)
        (setq mail-user-agent 'mew-user-agent))
    (if (fboundp 'define-mail-user-agent)
        (define-mail-user-agent
          'mew-user-agent
          'mew-user-agent-compose
          'mew-draft-send-message
          'mew-draft-kill
          'mew-send-hook))))

