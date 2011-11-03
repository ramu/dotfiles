;;; 60_info.el ---
;; info
(require 'info)
(require 'info+)
(setq Info-directory-list
      (cons (expand-file-name "~/.emacs.d/share/info/")
            Info-default-directory-list))
(add-to-list 'Info-directory-list "~/.emacs.d/share/info/")



;; anything-*-info
(require 'anything)
(defvar anything-c-source-info-elisp-ja
  '((info-index . "elisp-ja.info")))

(defun anything-info-ja-at-point ()
  "Preconfigured `anything' for searching info at point."
  (interactive)
  (anything '(anything-c-source-info-elisp-ja
              )
            (thing-at-point 'symbol) nil nil nil "*anything info*"))


;; Python
(defvar anything-c-source-info-python-lib-ja
  '((info-index . "python-lib-jp.info")))
(defvar anything-c-source-info-python-ref-ja
  '((info-index . "python-ref-jp.info")))
(defvar anything-c-source-info-python-api-ja
  '((info-index . "python-api-jp.info")))
(defvar anything-c-source-info-python-ext-ja
  '((info-index . "python-ext-jp.info")))
(defvar anything-c-source-info-python-tut-ja
  '((info-index . "python-tut-jp.info")))
(defvar anything-c-source-info-python-dist-ja
  '((info-index . "python-dist-jp.info")))

(defun anything-info-python-at-point ()
  "Preconfigured `anything' for searching info at point."
  (interactive)
  (anything '(anything-c-source-info-python-lib-ja
              anything-c-source-info-python-ref-ja
              anything-c-source-info-python-api-ja
              anything-c-source-info-python-ext-ja
              anything-c-source-info-python-tut-ja
              anything-c-source-info-python-dist-ja)
            (thing-at-point 'symbol) nil nil nil "*anything info*"))

(global-set-key (kbd "C-M-;") 'anything-info-python-at-point)

