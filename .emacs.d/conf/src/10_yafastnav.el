;;; 10_yafastnav.el ---
(require 'yafastnav)
(global-set-key (kbd "C-:") 'yafastnav-jump-to-current-screen)

; ピンポイントで飛ぶので不要
;(global-set-key (kbd "C-c C-n") 'yafastnav-jump-to-forward)
;(global-set-key (kbd "C-c C-p") 'yafastnav-jump-to-backward)

