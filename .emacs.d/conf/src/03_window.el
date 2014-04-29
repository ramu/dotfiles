;;;; 03_window.el
(require '00_common)

;;; popup.el
;; ポップアップメニュー、カスケードポップアップメニュー、ツールチップの実現
;;; popup-select-window.el
;; ウィンドウ分割(3つ以上)の時、popup-menu*を使い縦型インラインで選択、移動先ウィンドウを選択
;; http://www.emacswiki.org/emacs/popup-select-window.el
(my-require-and-when 'popup
  (my-require-and-when 'popup-select-window)
  (global-set-key "\C-xo" 'popup-select-window))

;;; hiwin.el
; 非アクティブなバッファ背景色を変更する
; https://github.com/tomoya/hiwin-mode
;(my-require-and-when 'hiwin
;  (setq hiwin-deactive-color "#222222")
;  (setq hiwin-readonly-color "#030310")
;  (hiwin-mode t))

;;; stripes.el
;; 偶数行の背景色を変更
;; http://www.emacswiki.org/cgi-bin/wiki/stripes.el
(my-require-and-when 'stripes
  (set-face-background 'stripes-face "#114422")
  ;(stripes-mode t)
  )

;;; switch-window.el
;; C-x oでwindow毎に数値表示、数値入力でそのwindowに移動
;; http://d.hatena.ne.jp/tomoya/20100807/1281150227
;(my-require-and-when 'switch-window)

;;; widen-window.el
;; Focusのあるwindowのサイズが自動的に大きくなる
;(my-require-and-when 'widen-window
;  (global-widen-window-mode t)
;  (setq ww-ratio 0.7))

;;; e2wm.el
;; emacs内Window管理ツール
;; http://d.hatena.ne.jp/kiwanami/20100528/1275038929
(my-require-and-when 'e2wm)

;;; popwin.el
;; ヘルプバッファや補完バッファをポップアップで表示
;; http://d.hatena.ne.jp/m2ym/20110120/1295524932
(my-require-and-when 'popwin
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
  (push '("*Anything Find File*"   :width 55 :position right :regexp t)   popwin:special-display-config)
  (push '("*my-anything*"          :width 55 :position right)             popwin:special-display-config)
  (push '(" *undo-tree*"           :width 55 :position right)             popwin:special-display-config)
  (push '("*Kill Ring*"            :width 55 :position right)             popwin:special-display-config)
  (push '("*Shell Command Output*" :width 55 :position right :noselect t) popwin:special-display-config)
  (push '("*quickrun*"             :width 55 :position right :noselect t) popwin:special-display-config)
  (push '("*Backtrace*"            :width 55                 :noselect t) popwin:special-display-config)
  (push '("*imenu-tree*"           :width 55 :position right)             popwin:special-display-config)
  (push '("*Occur*"                :width 55 :position right)             popwin:special-display-config)
  (push '("*slime-apropos*"        :width 55 :position right)             popwin:special-display-config)
  (push '("*slime-macroexpansion*" :width 55 :position right)             popwin:special-display-config)
  (push '("*slime-description*"    :width 55 :position right)             popwin:special-display-config)
  (push '("*slime-compilation*"    :width 55 :position right :noselect t) popwin:special-display-config)
  (push '("*slime-xref*"           :width 55 :position right)             popwin:special-display-config)
  (push '(sldb-mode                :width 55 :position right :stick t)    popwin:special-display-config)
  (push '(slime-repl-mode          :width 55 :position right)             popwin:special-display-config)
  (push '(slime-connection-list-mode :width 55 :position right)           popwin:special-display-config)
  ;; bottom
  (push '(" *auto-async-byte-compile*" :height 25 :position bottom :noselect t) popwin:special-display-config)
  (push '("*Test Result*"              :height 25 :position bottom :noselect t :stick t) popwin:special-display-config))
