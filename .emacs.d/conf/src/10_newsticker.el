;;; 10_newsticker.el ---
(setq newsticker-url-list
      '(("Linux World" "http://www.linuxworld.com/rss/linux-news.xml")
        ("Linux.com" "http://www.linux.com/feature?theme=rss")))

(autoload 'w3m-region "w3m" "Render region in current buffer and replace wit result." t)
(setq newsticker-html-renderer 'w3m-region)
(setq browse-url-browser-function 'w3m-browse-url)
