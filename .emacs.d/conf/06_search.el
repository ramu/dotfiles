;;;; 06_search.el
(require '00_common)

;;; color-moccur.el
;; moccurの改良版
;; http://www.emacswiki.org/emacs/color-moccur.el
(my-require-and-when 'color-moccur
  (setq moccur-split-word t))

;;; grep-edit.el
;; grep結果から編集
;; http://www.emacswiki.org/emacs/grep-edit.el
(my-require-and-when 'grep-edit)

;;; grep-a-lot.el
;; 複数の grep 結果を参照できる
;; http://www.emacswiki.org/emacs/grep-a-lot.el
(my-require-and-when 'grep-a-lot
  (grep-a-lot-setup-keys))
