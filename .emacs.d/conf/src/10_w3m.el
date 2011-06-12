;;; 10_w3m.el --- 
(require 'w3m-load)
(autoload 'w3m "w3m" "Interface for w3m on Emacs." t)
(autoload 'w3m-find-file "w3m" "w3m interface function for local file." t)
(autoload 'w3m-search "w3m-search" "Search QUERY using SEARCH_ENGINE." t)
(autoload 'w3m-weather "w3m-weather" "Display weather report." t)
(autoload 'w3m-antenna "w3m-antenna" "Report chenge of WEB sites." t)
(autoload 'w3m-namazu "w3m-namazu" "Searchfiles with Namazu." t)

; set-variables
(setq w3m-icon-directory "/Applications/MacPorts/Emacs.app/Contents/Resource/etc/w3m/")
(setq w3m-namazu-tmp-file-name "~/.nmz.html")
(setq w3m-namazu-index-file "~/.w3m-namazu.index")
(setq w3m-bookmark-file "~/.w3m/bookmark.html") 
(setq w3m-home-page "http://www.google.co.jp")
(setq w3m-default-display-inline-images t)

;; browse-url( C-x w )
; htmlの編集ではw3m使いたくないので無効化
;(setq browse-url-browser-function 'w3m-browse-url)
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
(global-set-key "\C-xw" 'browse-url-at-point)

