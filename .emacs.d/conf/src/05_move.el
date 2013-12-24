;;;; 05_move.el
(require '00_common)

;;; jaunte.el
;; Hit a Hint
;; http://kawaguchi.posterous.com/emacshit-a-hint
(my-require-and-when 'jaunte
  (global-set-key (kbd "C-:") 'jaunte))

;;; inertial-scroll.el
;; Šµ«ƒXƒNƒ[ƒ‹
;; http://d.hatena.ne.jp/kiwanami/20101008/1286518936
(my-require-and-when 'inertial-scroll
  (inertias-global-minor-mode 1)
  (setq inertias-initial-velocity 410)
  (setq inertias-friction 2000)
  (setq inertias-update-time 5)
  (setq inertias-rest-coef 0.1)
  (setq inertias-global-minor-mode-map
        (inertias-define-keymap
         '( ;; Mouse wheel scrolling
           ("<wheel-up>"   . inertias-down-wheel)
           ("<wheel-down>" . inertias-up-wheel)
           ("<mouse-4>"    . inertias-down-wheel)
           ("<mouse-5>"    . inertias-up-wheel)
           ;; Scroll keys
           ("<next>"  . inertias-up)
           ("<prior>" . inertias-down)
           ("C-v"     . inertias-up)
           ("M-v"     . inertias-down)
           ) inertias-prefix-key)))
