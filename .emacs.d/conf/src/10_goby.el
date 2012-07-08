;;; 10_goby.el ---
(require '00_common)

(my-require-and-when 'goby
  (setq goby-theme 'dark)
  (add-hook 'goby-view-mode-enter-hook
            (lambda ()
              (set-face-background 'region "#FFFFFF")
              (global-hl-line-mode nil))))

