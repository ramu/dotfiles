;;; 10_popwin.el --- 
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)
(setq popwin:popup-window-position 'right)
(setq popwin:popup-window-width 100)

;; right
(push '("*Messages*"             :width 55 :position right :noselect t) popwin:special-display-config)
(push '("*Help*"                 :width 55 :position right :noselect t) popwin:special-display-config)
(push '("*compilation*"          :width 55 :position right :noselect t) popwin:special-display-config)
(push '("*Completions*"          :width 55 :position right :noselect t) popwin:special-display-config)
(push '("*interpretation*"       :width 55 :position right :noselect t) popwin:special-display-config)
(push '("*anything*"             :width 55 :position right)             popwin:special-display-config)
(push '("*anything commands*"    :width 55 :position right)             popwin:special-display-config)
(push '("*anything colors*"      :width 55 :position right)             popwin:special-display-config)
(push '("*anything complete*"    :width 55 :position right)             popwin:special-display-config)
(push '("*anything kill-ring*"   :width 55 :position right)             popwin:special-display-config)
(push '("*anything grep"         :width 55 :position right :regexp t)   popwin:special-display-config)
(push '("*my-anything*"          :width 55 :position right)             popwin:special-display-config)
(push '(" *undo-tree*"           :width 55 :position right)             popwin:special-display-config)
(push '("*Kill Ring*"            :width 55 :position right)             popwin:special-display-config)
(push '("*Shell Command Output*" :width 55 :position right :noselect t) popwin:special-display-config)
(push '("*Backtrace*"            :width 55                 :noselect t) popwin:special-display-config)
(push '("*imenu-tree*"           :width 55 :position right)             popwin:special-display-config)


;; bottom
(push '(" *auto-async-byte-compile*" :height 25 :position bottom :noselect t) popwin:special-display-config)
(push '("*Test Result*"              :height 25 :position bottom :noselect t :stick t) popwin:special-display-config)