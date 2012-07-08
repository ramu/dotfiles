;;; 10_navi2ch.el ---
(require '00_common)

(my-autoload-and-when 'navi2ch
  (setq navi2ch-mona-enable t)
  (setq navi2ch-mona-face-variable 'navi2ch-mona16-face)
  (setq navi2ch-article-auto-range nil))
