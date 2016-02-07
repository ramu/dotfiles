;;; 60_info.el ---
(require '00_common)

;; info
(my-require-and-when 'info
  (my-require-and-when 'info+)

  (setq Info-directory-list
        (cons (expand-file-name "~/.emacs.d/share/info/")
              Info-default-directory-list))
  (add-to-list 'Info-directory-list "~/.emacs.d/share/info/"))
