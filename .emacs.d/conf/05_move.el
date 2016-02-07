;;;; 05_move.el
(require '00_common)

;;; jaunte.el
;; Hit a Hint
;; http://kawaguchi.posterous.com/emacshit-a-hint
(my-require-and-when 'jaunte
    (global-set-key (kbd "C-;") 'jaunte))
