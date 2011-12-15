;;;; 06_search.el

;;; color-moccur.el
;; moccurの改良版
;; http://www.emacswiki.org/emacs/color-moccur.el
(require 'color-moccur)
(setq moccur-split-word t)

;;; grep-edit.el
;; grep結果から編集
;; http://www.emacswiki.org/emacs/grep-edit.el
(require 'grep-edit)

;;; grep-a-lot.el
;; 複数の grep 結果を参照できる
;; http://www.emacswiki.org/emacs/grep-a-lot.el
(require 'grep-a-lot)
(grep-a-lot-setup-keys)

