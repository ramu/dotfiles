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

;;; stripes.el
;; 偶数行の背景色を変更
(my-require-and-when 'stripes
  (set-face-background 'stripes-face "#114422"))

;;; e2wm.el
;; emacs内Window管理ツール
;; http://d.hatena.ne.jp/kiwanami/20100528/1275038929
(my-require-and-when 'e2wm
  (my-require-and-when 'e2wm-vcs)
  (e2wm:add-keymap e2wm:pst-minor-mode-keymap
                   '(("M-w" . e2wm:dp-magit))
                              e2wm:prefix-key))

;;; popwin.el
;; ヘルプバッファや補完バッファをポップアップで表示
;; http://d.hatena.ne.jp/m2ym/20110120/1295524932
(my-require-and-when 'popwin
  (setq display-buffer-function 'popwin:display-buffer)
  (setq popwin:popup-window-position 'right)
  (if window-system (progn
                      (if (string-match "jm.local" system-name)
                          ;; macbook
                          (setq popwin:popup-window-width 75)
                        ;; macbookpro
                        (setq popwin:popup-window-width 100))))
  ;; right
  (push '("*Messages*"               :position right :noselect t) popwin:special-display-config)
  (push '("*Help*"                   :position right :noselect t) popwin:special-display-config)
  (push '("*compilation*"            :position right :noselect t) popwin:special-display-config)
  (push '("*Completions*"            :position right :noselect t) popwin:special-display-config)
  (push '("*interpretation*"         :position right :noselect t) popwin:special-display-config)
  (push '("^\*[aA]nything.+\*$"      :position right :regexp t)   popwin:special-display-config)
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

