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
(my-require-and-when 'e2wm
  (my-require-and-when 'e2wm-vcs)
  (e2wm:add-keymap e2wm:pst-minor-mode-keymap
                   '(("M-w" . e2wm:dp-magit))
                   e2wm:prefix-key))

;;; elscreen
;; Emacs session window manager
(my-require-and-when 'elscreen
  (my-require-and-when 'elscreen-color-theme)
  (my-require-and-when 'elscreen-server)
  (my-require-and-when 'elscreen-dired)

  (setq elscreen-prefix-key (kbd "C-z"))
  (setq elscreen-tab-display-kill-screen nil)
  (setq elscreen-tab-display-control nil)
  (custom-set-faces '(elscreen-tab-background-face ((((class color)) (:background "#333333"))))
                    '(elscreen-tab-current-screen-face ((((class color)) (:background "#444400" :foreground "goldenrod" :bold t :underline t))))
                    '(elscreen-tab-other-screen-face ((((class color)) (:background "black" :foreground "#AAAAAA")))))
  (elscreen-start))

;;; popwin.el
;; ヘルプバッファや補完バッファをポップアップで表示
;; http://d.hatena.ne.jp/m2ym/20110120/1295524932
(my-require-and-when 'popwin
  (setq display-buffer-function 'popwin:display-buffer)
  (setq popwin:popup-window-position 'right)
  (setq popwin:popup-window-width 100)
  ;; right
  (push '("*Messages*"               :position right :noselect t) popwin:special-display-config)
  (push '("*Help*"                   :position right :noselect t) popwin:special-display-config)
  (push '("*compilation*"            :position right :noselect t) popwin:special-display-config)
  (push '("*Completions*"            :position right :noselect t) popwin:special-display-config)
  (push '("*interpretation*"         :position right :noselect t) popwin:special-display-config)
  (push '("^\*[aA]nything.+\*$"      :position right :regexp t)   popwin:special-display-config)
  (push '("*my-anything*"            :position right)             popwin:special-display-config)
  (push '("*my-helm*"                :position right)             popwin:special-display-config)
  (push '("^\*[hH]elm.+\*$"          :position right :regexp t)   popwin:special-display-config)
  (push '(" *undo-tree*"             :position right)             popwin:special-display-config)
  (push '("*Kill Ring*"              :position right)             popwin:special-display-config)
  (push '("*Shell Command Output*"   :position right :noselect t) popwin:special-display-config)
  (push '("*quickrun*"               :position right :noselect t) popwin:special-display-config)
  (push '("*Backtrace*"                              :noselect t) popwin:special-display-config)
  (push '("*imenu-tree*"             :position right)             popwin:special-display-config)
  (push '("*Occur*"                  :position right)             popwin:special-display-config)
  (push '("*slime-apropos*"          :position right)             popwin:special-display-config)
  (push '("*slime-macroexpansion*"   :position right)             popwin:special-display-config)
  (push '("*slime-description*"      :position right)             popwin:special-display-config)
  (push '("*slime-compilation*"      :position right :noselect t) popwin:special-display-config)
  (push '("*slime-xref*"             :position right)             popwin:special-display-config)
  (push '(sldb-mode                  :position right :stick t)    popwin:special-display-config)
  (push '(slime-repl-mode            :position right)             popwin:special-display-config)
  (push '(slime-connection-list-mode :position right)           popwin:special-display-config)
  ;; bottom
  (push '(" *auto-async-byte-compile*" :height 25 :position bottom :noselect t) popwin:special-display-config)
  (push '("*Test Result*"              :height 25 :position bottom :noselect t :stick t) popwin:special-display-config))
