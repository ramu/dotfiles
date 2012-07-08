;;; 10_newsticker.el ---
(require '00_common)

(my-autoload-and-when 'w3m-region "w3m-region"
  (setq newsticker-url-list
        '(("Linux World" "http://www.linuxworld.com/rss/linux-news.xml")
          ("Linux.com" "http://www.linux.com/feature?theme=rss")))
  (setq newsticker-html-renderer 'w3m-region)
  (setq browse-url-browser-function 'w3m-browse-url))
