;;;; 03_window.el

;;; popup-select-window.el
;; ウィンドウ分割(3つ以上)の時、popup-menu*を使い縦型インラインで選択、移動先ウィンドウを選択
;; http://www.emacswiki.org/emacs/popup-select-window.el
(require 'popup)
(require 'popup-select-window)
(global-set-key "\C-xo" 'popup-select-window)

;;; hiwin.el
; 非アクティブなバッファ背景色を変更する
; https://github.com/tomoya/hiwin-mode
(require 'hiwin)
(setq hiwin-deactive-color "#222222")
(setq hiwin-readonly-color "#030310")
(hiwin-mode)

;;; stripes.el
;; 偶数行の背景色を変更
;; http://www.emacswiki.org/cgi-bin/wiki/stripes.el
(require 'stripes)
(set-face-background 'stripes-face "#114422")
;(stripes-mode t)

;;; switch-window.el
;; C-x oでwindow毎に数値表示、数値入力でそのwindowに移動
;; http://d.hatena.ne.jp/tomoya/20100807/1281150227
;(require 'switch-window)

;;; widen-window.el
;; Focusのあるwindowのサイズが自動的に大きくなる
;(require 'widen-window)
;(global-widen-window-mode t)
;(setq ww-ratio 0.7)

;;; e2wm.el
;; emacs内Window管理ツール
;; http://d.hatena.ne.jp/kiwanami/20100528/1275038929
(require 'e2wm)

;;; popup.el
;; ポップアップメニュー、カスケードポップアップメニュー、ツールチップの実現
;; http://d.hatena.ne.jp/m2ym/20091213/1260678801
(require 'popup)

;;; elscreen.el
;; ElScreenは window-configuration-to-register / jump-to-register と同様のことを、
;; GNU Screenのようなより洗練されたインターフェイスで提供することを目的としたものです。
;; http://www.morishima.net/~naoto/elscreen-ja/
(require 'elscreen)
; 自動でスクリーン作成
(defmacro elscreen-create-automatically (ad-do-it)
  `(if (not (elscreen-one-screen-p))
       ,ad-do-it
     (elscreen-create)
     (elscreen-notify-screen-modification 'force-immediately)
     (elscreen-message "New screen is automatically created")))
(defadvice elscreen-next (around elscreen-create-automatically activate)
  (elscreen-create-automatically ad-do-it))
(defadvice elscreen-previous (around elscreen-previous activate)
  (elscreen-create-automatically ad-do-it))
(defadvice elscreen-toggle (around elscreen-create-automatically activate)
  (elscreen-create-automatically ad-do-it))

;;; popwin.el
;; ヘルプバッファや補完バッファをポップアップで表示
;; http://d.hatena.ne.jp/m2ym/20110120/1295524932
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
(push '("*Test Result*"              :height 25 :position bottom :noselect t :stick t) popwin:special-display-config)

