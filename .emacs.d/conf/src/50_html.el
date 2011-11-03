;;; 50_html.el ---
;; default browser
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "open")

(add-hook 'html-mode-hook (lambda ()
                            (html-autoview-mode)))


