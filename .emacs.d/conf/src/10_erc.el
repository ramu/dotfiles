;;; 10_erc.el ---
(require '00_common)

(my-require-and-when 'erc
  (setq erc-server-coding-system '(utf-8 . utf-8))
  (setq erc-server "irc.freenode.net"
        erc-port 6667
        erc-nick "ramusara"
        erc-user-full-name "ramusara jackson"
        erc-email-userid "ramusara"
        erc-prompt-for-password nil)

  ;; autojoin
  (my-require-and-when 'erc-join
    (erc-autojoin-mode t)
    (setq erc-autojoin-channels-alist
          '(("freenode.net"
           "#ramusara"
             ;"#haskell"
             ;"#git"
             ;"#ruby"
             ;"#perl"
             ;"#python"
             ;"#zsh"
             "#nico-lib"
             ;"##C++"
             ;"#github"
             ;"#ubuntu-jp"
             ;"#slashdot-jp"
             ;"#emacs"
             ;"#emacs-ja"
             ;"#emacs-lisp-ja"
             ;"#pypy"
             ;"#mercurial"
             ;"#lisp"
             ))))

  ;; track
  (my-require-and-when 'erc-track
    (erc-track-mode t))

  ;; truncate
  (my-require-and-when 'erc-truncate
    (defvar erc-insert-post-hook)
    (add-hook 'erc-insert-post-hook 'erc-truncate-buffer)
    (setq erc-max-buffer-size 10000)
    (setq erc-truncate-buffer-on-save t))

  ;; highlighting references
  (my-require-and-when 'erc-match
    (setq erc-keywords '("ramusara"))
    (erc-match-mode t))

  ;; netsplit
  (my-require-and-when 'erc-netsplit
    (erc-netsplit-mode t))

  ;; timestamp
  (my-require-and-when 'erc-stamp
    (erc-timestamp-mode t)
    (setq erc-timestamp-format "[%R-%m/%d]"))

  ;; hooks
  (add-hook 'erc-mode-hook
            '(lambda ()
               (my-require-and-when 'erc-pcomplete
                 (pcomplete-erc-setup)
                 (erc-completion-mode t))
               (setq show-trailing-whitespace nil)))

  ;; translation
  ; babel.elが古い...
  ;(my-require-and-when 'erc-babel)

  ;;; auto-connenct
  ;(erc :server "irc.freenode.net" :full-name "ramusara" :nick "ramusara")
  )
