;;; 10_w3m.el ---
(require '00_common)

(my-require-and-when 'w3m-load
  (my-autoload-and-when 'w3m "w3m")
  (my-autoload-and-when 'w3m-find-file "w3m")
  (my-autoload-and-when 'w3m-search "w3m-search")
  (my-autoload-and-when 'w3m-weather "w3m-weather")
  (my-autoload-and-when 'w3m-antenna "w3m-antenna")
  (my-autoload-and-when 'w3m-namazu "w3m-namazu")

  ; set-variables
  (setq w3m-icon-directory "/Applications/MacPorts/Emacs.app/Contents/Resource/etc/w3m/")
  (setq w3m-namazu-tmp-file-name "~/.w3m/.nmz.html")
  (setq w3m-namazu-index-file "~/.w3m/.w3m-namazu.index")
  (setq w3m-bookmark-file "~/.w3m/bookmark.html")
  (setq w3m-home-page "http://www.google.co.jp")
  (setq w3m-default-display-inline-images t)

  ;; browse-url( C-x w )
  ; htmlの編集ではw3m使いたくないので無効化
  ;(setq browse-url-browser-function 'w3m-browse-url)
  (my-autoload-and-when 'w3m-browse-url "w3m"
                        (global-set-key "\C-xw" 'browse-url-at-point)))
