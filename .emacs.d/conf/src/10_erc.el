;;; 10_erc.el ---
(require 'erc)

(setq erc-server-coding-system '(utf-8 . utf-8))
(setq erc-server "irc.freenode.net"
      erc-port 6667
      erc-nick "ramusara"
      erc-user-full-name "ramusara jackson"
      erc-email-userid "ramusara"
      erc-prompt-for-password nil)

;; autojoin
(require 'erc-join)
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
         )))

;; track
(require 'erc-track)
(erc-track-mode t)

;; truncate
(require 'erc-truncate)
(defvar erc-insert-post-hook)
(add-hook 'erc-insert-post-hook 'erc-truncate-buffer)
(setq erc-max-buffer-size 10000)
(setq erc-truncate-buffer-on-save t)

;; highlighting references
(require 'erc-match)
(setq erc-keywords '("ramusara"))
(erc-match-mode)

;; netsplit
(require 'erc-netsplit)
(erc-netsplit-mode t)

;; timestamp
(require 'erc-stamp)
(erc-timestamp-mode t)
(setq erc-timestamp-format "[%R-%m/%d]")

;; hooks
(add-hook 'erc-mode-hook
          '(lambda ()
             (require 'erc-pcomplete)
             (pcomplete-erc-setup)
             (erc-completion-mode 1)
             (setq show-trailing-whitespace nil)))

;; translation
; babel.elが古い...
;(require 'erc-babel)

;;; auto-connenct
;(erc :server "irc.freenode.net" :full-name "ramusara" :nick "ramusara")
