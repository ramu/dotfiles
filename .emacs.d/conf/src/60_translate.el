;;;; 11_translate.el
(require '00_common)

;;; text-translator.el
;; テキスト翻訳サービスを提供するウェブサイトを利用してEmacs 上で文字列の翻訳を行う
;; http://d.hatena.ne.jp/khiker/20070503/emacs_text_translator
(my-require-and-when 'text-translator
  (setq text-translator-auto-selection-func
        'text-translator-translate-by-auto-selection-enja))

;;; sdic.el
(my-require-and-when 'sdic
  (autoload 'sdic-describe-word "sdic" "英単語辞書" t nil)
  (global-set-key (kbd "C-c w") 'sdic-describe-word)
  (autoload 'sdic-describe-word-at-point "sdic" "英単語辞書(カーソル位置)" t nil)
  (global-set-key (kbd "C-c W") 'sdic-describe-word-at-point)
  (setq sdic-eiwa-dictionary-list '((sdicf-client "/usr/local/share/dict/gene.sdic")))
  (setq sdic-waei-dictionary-list '((sdicf-client "/usr/local/share/dict/jedict.sdic")))

  ;;; sdic-inline.el
  (my-require-and-when 'sdic-inline
    (my-require-and-when 'popup)     ; popup有効
    (sdic-inline-mode t)
    (setq sdic-inline-eiwa-dictionary "/usr/local/share/dict/gene.sdic")
    (setq sdic-inline-waei-dictionary "/usr/local/share/dict/jedict.sdic")
    (setq sdic-inline-enable-modes nil)

    ;;; sdic-inline-pos-tip.el
    (my-require-and-when 'sdic-inline-pos-tip
      (setq sdic-inline-search-func 'sdic-inline-search-word-with-stem)
      (setq sdic-inline-display-func 'sdic-inline-pos-tip-show)
      (define-key sdic-inline-map (kbd "C-c C-p") 'sdic-inline-pos-tip-show)
      (setq transient-mark-mode t))))
