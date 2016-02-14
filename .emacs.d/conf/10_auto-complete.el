;; 10_auto-complete.el
(require '00_common)

(my-require-and-when 'auto-complete
    (my-require-and-when 'auto-complete-extension)
    ;(my-require-and-when 'auto-complete-yasnippet)
    (my-require-and-when 'auto-complete-config)
    ;(my-require-and-when 'auto-complete-clang)
    (my-require-and-when 'pcomplete)

    ;; default
    (ac-config-default)

    ; pos-tip.el利用
    (my-require-and-when 'pos-tip
      (setq ac-quick-help-prefer-x t))

    ;; config
    (global-auto-complete-mode t)
    (set-face-background 'ac-candidate-face "lightgray")
    (set-face-background 'ac-selection-face "steelblue")
    (define-key ac-completing-map (kbd "C-n") 'ac-next)
    (define-key ac-completing-map (kbd "C-p") 'ac-previous)

    (setq ac-auto-show-menu 0.3)             ; 補完時に自動的に補完メニューを表示するか(遅延時間:秒数)
    (setq ac-candidate-limit 10)             ; 補完候補数
    (setq ac-dwim t)
    (setq ac-delay 0.5)                      ; 補完可能になるまでの遅延時間（秒）を実数で指定
    (setq ac-use-quick-help t)               ; クイックヘルプを利用するか
    (setq ac-use-comphist t)                 ; 補完推測機能を利用するか
    (setq ac-quick-help-delay 0)             ; クイックヘルプを表示するまでの時間（秒）を実数で指定
    (setq ac-stop-flymake-on-completing t)   ; 補完時にflymakeを中止
    (setq ac-comphist-file "~/.emacs.d/var/ac-comphist.dat")
    (add-to-list 'ac-dictionary-directories "~/.emacs.d/share/ac-dict")

    (add-to-list 'ac-modes 'eshell-mode)
    (ac-define-source pcomplete
      '((candidates . pcomplete-completions)))

    ;; source
    (setq-default ac-sources '(ac-source-filename ac-source-words-in-same-mode-buffers ac-source-abbrev))
    (add-hook 'emacs-lisp-mode-hook (lambda () (add-to-list 'ac-sources 'ac-source-symbols t)))
    (add-hook 'eshell-mode-hook     (lambda () (add-to-list 'ac-sources '(ac-source-pcomplete ac-source-dictionary ac-source-symbols))))
    (add-hook 'python-mode-hook     (lambda () (add-to-list 'ac-sources 'ac-source-yasnippet)))
    (add-hook 'c-mode-common-hook   (lambda () (add-to-list 'ac-sources '(ac-source-gtags ac-source-yasnippet))))
    (add-hook 'c-mode-hook          (lambda () (add-to-list 'ac-sources '(ac-source-gtags ac-source-yasnippet))))
    (add-hook 'c++-mode-hook        (lambda () (add-to-list 'ac-sources '(ac-source-yasnippet)))))
