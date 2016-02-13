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
  ;; bottom
  (push '("*Messages*"                 :height 25 :position bottom :noselect t) popwin:special-display-config)
  (push '("*Help*"                     :height 25 :position bottom :noselect t) popwin:special-display-config)
  (push '("*compilation*"              :height 25 :position bottom :noselect t) popwin:special-display-config)
  (push '("*Completions*"              :height 25 :position bottom :noselect t) popwin:special-display-config)
  (push '("*interpretation*"           :height 25 :position bottom :noselect t) popwin:special-display-config)
  (push '("^\*[aA]nything.+\*$"        :height 25 :position bottom :regexp t)   popwin:special-display-config)
  (push '("*my-helm*"                  :height 25 :position bottom)             popwin:special-display-config)
  (push '("^\*[hH]elm.+\*$"            :height 25 :position bottom :regexp t)   popwin:special-display-config)
  (push '(" *undo-tree*"               :height 25 :position bottom)             popwin:special-display-config)
  (push '("*Kill Ring*"                :height 25 :position bottom)             popwin:special-display-config)
  (push '("*Shell Command Output*"     :height 25 :position bottom :noselect t) popwin:special-display-config)
  (push '("*quickrun*"                 :height 25 :position bottom :noselect t) popwin:special-display-config)
  (push '("*Backtrace*"                :height 25 :position bottom :noselect t) popwin:special-display-config)
  (push '("*imenu-tree*"               :height 25 :position bottom)             popwin:special-display-config)
  (push '("*Occur*"                    :height 25 :position bottom)             popwin:special-display-config)
  (push '("*slime-apropos*"            :height 25 :position bottom)             popwin:special-display-config)
  (push '("*slime-macroexpansion*"     :height 25 :position bottom)             popwin:special-display-config)
  (push '("*slime-description*"        :height 25 :position bottom)             popwin:special-display-config)
  (push '("*slime-compilation*"        :height 25 :position bottom :noselect t) popwin:special-display-config)
  (push '("*slime-xref*"               :height 25 :position bottom)             popwin:special-display-config)
  (push '(sldb-mode                    :height 25 :position bottom :stick t)    popwin:special-display-config)
  (push '(slime-repl-mode              :height 25 :position bottom)             popwin:special-display-config)
  (push '(slime-connection-list-mode   :height 25 :position bottom)             popwin:special-display-config)
  (push '(" *auto-async-byte-compile*" :height 25 :position bottom :noselect t) popwin:special-display-config)
  (push '("*Test Result*"              :height 25 :position bottom :noselect t :stick t) popwin:special-display-config))
