;;; 90_inertial-scroll.el --- 
(require 'inertial-scroll)
(inertias-global-minor-mode 1)

(setq inertias-initial-velocity 410)
(setq inertias-friction 2000)
(setq inertias-update-time 5)
(setq inertias-rest-coef 0.1)
(setq inertias-global-minor-mode-map 
      (inertias-define-keymap
        '(
          ;; Mouse wheel scrolling
          ("<wheel-up>"   . inertias-down-wheel)
          ("<wheel-down>" . inertias-up-wheel)
          ("<mouse-4>"    . inertias-down-wheel)
          ("<mouse-5>"    . inertias-up-wheel)
          ;; Scroll keys
          ("<next>"  . inertias-up)
          ("<prior>" . inertias-down)
          ("C-v"     . inertias-up)
          ("M-v"     . inertias-down)
          ) inertias-prefix-key))

