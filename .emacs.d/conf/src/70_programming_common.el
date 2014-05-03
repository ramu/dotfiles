;;;; 70_programming_common.el ---
(require '00_common)

;;; 現在の関数名を常に表示する
(my-require-and-when 'which-func
  (which-func-mode t)
  (setq which-func-modes t))           ; すべてのメジャーモードに対してwhich-func-modeを適用する

;;; gdb
(setq gdb-many-windows t)              ; 有用なバッファを開く
(setq gdb-use-separate-io-buffer nil)  ; I/Oバッファを非表示
(setq gdb-tooltip-echo-area t)         ; tにするとmini bufferに値表示

;;; paredit.el
;; 括弧の対応を取りながら編集できる
;; http://www.emacswiki.org/emacs/ParEdit
(my-require-and-when 'paredit
  (add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
  (add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
  (add-hook 'lisp-mode-hook 'enable-paredit-mode)
  (add-hook 'ielm-mode-hook 'enable-paredit-mode)
  (define-key paredit-mode-map (kbd "M-;") nil))

;;; summarye.el
;; 関数の一覧を表示
;; http://www.emacswiki.org/emacs/summarye.el
(my-require-and-when 'summarye)

;;; kokopelli.el
;; 関数一覧表示
;; http://www.emacswiki.org/emacs/kokopelli.el
(my-require-and-when 'kokopelli
  (setq kokopelli-auto-quit t)   ; 関数選んだら閉じる
  (define-key global-map [f12] 'kokopelli-sing))

;;; auto-async-byte-compile.el
;; 自動バイトコンパイル
;; http://d.hatena.ne.jp/rubikitch/20100423/bytecomp
(my-require-and-when 'auto-async-byte-compile
  (setq auto-async-byte-compile-exclude-files-regexp "/junk/")
  (add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)
  ; auto-async-byte-compileが完了した後、
  ; /.emacs.d/conf/src/ と /.emacs.d/elisp/src/配下に関しては
  ; 自動的に/src/から一階層上に.elcファイルを移動させる
  (add-hook 'auto-async-byte-compile-hook
            (lambda () (let (compiled_name target_name)
                         (setq compiled_name (concat buffer-file-name "c"))
                         (if (file-exists-p compiled_name)
                             (if (string-match "/.emacs.d/\\(conf\\|elisp\\)/src/" compiled_name)
                                 (progn
                                   (setq target_name (replace-regexp-in-string "/src/" "/" compiled_name))
                                   (rename-file compiled_name target_name t)
                                   (message "auto-async-byte-compile:ok, move:ok -> %s" target_name)
                                   (eval-buffer))))))))

;;; quickrun.el
;; Run commands quickly.
;; http://d.hatena.ne.jp/syohex/20111201/1322665378
(my-require-and-when 'quickrun
  (push '("quickrun*") popwin:special-display-config))

;;; gtags.el
;; GNU GLOBAL(gtags)
;; http://www.gnu.org/software/global/global.html
(my-require-and-when 'gtags
  (add-hook 'c-mode-common-hook 'gtags-mode)
  (add-hook 'c++-mode-hook 'gtags-mode)
  (add-hook 'java-mode-hook 'gtags-mode))

;;; mode-compile.el
;; ModeCompile provides a smart command for compiling files according to major-mode.
;; http://www.emacswiki.org/emacs/ModeCompile
(my-require-and-when 'mode-compile
  (global-set-key "\C-cc" 'mode-compile)
  (setq mode-compile-expert-p t)
  (setq mode-compile-reading-time 0))

;;; imenu+.el
;; Extensions to `imenu.el'.
;; http://www.emacswiki.org/emacs/imenu+.el
(my-require-and-when 'imenu+)

;;; imenu-tree.el
;; imenuをツリー表示
;; http://d.hatena.ne.jp/buzztaiki/20071021/1192933521
(my-require-and-when 'imenu-tree
  (setq imenu-tree-auto-update t))

;;; cpp-complt.el
;; C/C++で #... を補完
;; http://www.bookshelf.jp/soft/meadow_41.html#SEC611
(my-require-and-when 'cpp-complt
  (add-hook 'c-mode-common-hook
      (function (lambda ()
          (local-set-key [mouse-2] 'cpp-complt-include-mouse-select)
          (local-set-key "#" 'cpp-complt-instruction-completing)
          (local-set-key "\C-c#" 'cpp-complt-ifdef-region)
          (cpp-complt-init))))
  (setq cpp-complt-standard-header-path
        '("/usr/include/"
          "/usr/include/c++/4.2.1/"
          "/opt/local/include/"
          "/usr/local/include/glib-2.0"   ;; glib
          "/usr/local/include/gtk-2.0"    ;; gtk-2.0
          "/opt/local/include/boost/")))  ;; boost

;;; test-case-mode.el
;; テスト駆動開発支援
;; http://nschum.de/src/emacs/test-case-mode/
(my-autoload-and-when 'test-case-mode "test-case-mode"
  (my-autoload-and-when 'enable-test-case-mode-if-test "test-case-mode")
  (my-autoload-and-when 'test-case-find-all-tests "test-case-mode")
  (my-autoload-and-when 'test-case-compilation-finish-run-all "test-case-mode")
  (my-require-and-when 'test-case-pynose)
  (add-hook 'find-file-hook 'enable-test-case-mode-if-test)
  (add-hook 'compilation-finish-functions 'test-case-compilation-finish-run-all)
  (add-hook 'after-save-hook (lambda () (if test-case-mode (test-case-run)))))

;;; sr-speedbar.el
;; 関数一覧表示
;; http://www.emacswiki.org/emacs/sr-speedbar.el
(my-require-and-when 'sr-speedbar
  (setq sr-speedbar-right-side nil)
  ;(sr-speedbar-open)
  ;; configure
  (setq sr-speedbar-width-x 15)
  (setq sr-speedbar-max-width 20))

;;; xcscope.el
;; cscopeと連携
;; http://cscope.sourceforge.net/
(my-require-and-when 'xcscope)

;;; gist.el
;; Emacs integration for gist.github.com
;; https://github.com/defunkt/gist.el
(my-require-and-when 'gist
  (setq gist-view-gist t)
  (setq github-user "ramusara"))

;;; magit.el
;; A Emacs mode for Git.
;; http://philjackson.github.com/magit/
(my-require-and-when 'magit
  (set-face-foreground 'magit-diff-add "green"))

;;; eldoc.el
;; カーソル位置の関数の仮引数をエコーエリアに表示
;; http://www.emacswiki.org/emacs/ElDoc
(my-require-and-when 'eldoc
  (setq eldoc-idle-delay 0)
  (setq eldoc-echo-area-use-multiline-p t)
  (add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
  (add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
  (add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
  (set-face-background 'eldoc-highlight-function-argument "#FF0000")
  (set-face-bold-p 'eldoc-highlight-function-argument nil))

;; eldoc-extension.el ; 使えない?
;(my-require-and-when 'eldoc-extension)

;; git-gutter+
(my-require-and-when 'git-gutter-fringe+
  (global-git-gutter+-mode))
