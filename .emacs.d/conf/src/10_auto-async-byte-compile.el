;; 10_auto-async-byte-compile.el
(require 'auto-async-byte-compile)
(setq auto-async-byte-compile-exclude-files-regexp "/junk/")
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)


; auto-async-byte-compileが完了した後、
; /.emacs.d/conf/src/ と /.emacs.d/elisp/src/配下に関しては
; 自動的に/src/から一階層上に.elcファイルを移動させる
(add-hook 'auto-async-byte-compile-hook
  (lambda ()
    (let (compiled_name target_name)
      (setq compiled_name (concat buffer-file-name "c"))
      (if (file-exists-p compiled_name)
        (if (string-match "/.emacs.d/\\(conf\\|elisp\\)/src/" compiled_name)
          (progn
            (setq target_name (replace-regexp-in-string "/src/" "/" compiled_name))
            (rename-file compiled_name target_name t)
            (message "auto-async-byte-compile:ok, move:ok -> %s" target_name)
            (eval-buffer)))))))


