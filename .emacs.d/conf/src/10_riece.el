;; 10_riece.el
; config = ~/.riece/init

(autoload 'riece "riece" "Start Riece" t)
;(require 'riece)
(add-to-list 'riece-addons 'riece-biff)
(add-to-list 'riece-addons 'riece-google)
(add-to-list 'riece-addons 'riece-keyword)
(add-to-list 'riece-addons 'riece-button)
(add-to-list 'riece-addons 'riece-highlight)
(add-to-list 'riece-addons 'riece-unread)
(add-to-list 'riece-addons 'riece-icon)
