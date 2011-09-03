;;; 10_flymake.el
(require 'flymake)
(require 'flymake-extension)
(require 'fringe-helper)
(require 'flymake-growl)

;; flymake-extension
(setq flymake-extension-use-showtip nil)
(setq flymake-extension-auto-show t)

; color変更
(set-face-background 'flymake-errline "red4")
(set-face-background 'flymake-warnline "dark slate blue")

; 待ち時間
(setq flymake-no-changes-timeout 5)


;;;;;;;;;;;;;;;;;;;;
; flymake for c    ;
;;;;;;;;;;;;;;;;;;;;
(defun flymake-cc-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                     temp-file
                     (file-name-directory buffer-file-name))))
   (list "g++" (list "-I." "-Wall" "-Wextra" "-fsyntax-only" local-file))))

(push '("\\.cpp$" flymake-cc-init) flymake-allowed-file-name-masks)
(push '("\\.hpp$" flymake-cc-init) flymake-allowed-file-name-masks)
(push '("\\.cc$"  flymake-cc-init) flymake-allowed-file-name-masks)
(push '("\\.c$"   flymake-cc-init) flymake-allowed-file-name-masks)
(push '("\\.h$"   flymake-cc-init) flymake-allowed-file-name-masks)

(add-hook 'c-mode-common-hook (lambda () (flymake-mode t)))


;;;;;;;;;;;;;;;;;;;;
; flymake for perl ;
;;;;;;;;;;;;;;;;;;;;
(require 'set-perl5lib)

(defvar flymake-perl-err-line-patterns '(("\\(.*\\) at \\([^ \n]+\\) line \\([0-9]+\\)[,.\n]" 2 3 nil 1)))
(defconst flymake-allowed-perl-file-name-masks '(("\\.pl$" flymake-perl-init)
                                                 ("\\.pm$" flymake-perl-init)
                                                 ("\\.t$"  flymake-perl-init)))

(defun flymake-perl-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                    'flymake-create-temp-inplace))
        (local-file (file-relative-name
                    temp-file
                    (file-name-directory buffer-file-name))))
    (list "perl" (list "-wc" local-file))))

(defun flymake-perl-load ()
  (interactive)
  (set-perl5lib)
  (defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
    (setq flymake-check-was-interrupted t))
  (ad-activate 'flymake-post-syntax-check)
  (setq flymake-allowed-file-name-masks (append flymake-allowed-file-name-masks flymake-allowed-perl-file-name-masks))
  (setq flymake-err-line-patterns flymake-perl-err-line-patterns)
  (flymake-mode t))

(defun next-flymake-error ()
  (interactive)
  (flymake-goto-next-error)
  (let ((err (get-char-property (point) 'help-echo)))
    (when err
      (message err))))
(global-set-key "\M-e" 'next-flymake-error)
(add-hook 'cperl-mode-hook 'flymake-perl-load)


;;;;;;;;;;;;;;;;;;;;;;
; flymake for python ;
;;;;;;;;;;;;;;;;;;;;;;
;(when (load "flymake" t)
;  (defun flymake-pyflakes-init ()
;    (let* ((temp-file (flymake-init-create-temp-buffer-copy
;             'flymake-create-temp-inplace))
;     (local-file (file-relative-name
;          temp-file
;          (file-name-directory buffer-file-name))))
;    (list "pycheckers"  (list local-file))))
; (add-to-list 'flymake-allowed-file-name-masks
;          '("\\.py\\'" flymake-pyflakes-init)))


;;;;;;;;;;;;;;;;;;;;
; flymake for java ;
;;;;;;;;;;;;;;;;;;;;
;; redefine to remove "check-syntax" target
(defun flymake-get-make-cmdline (source base-dir)
  (list "make"
        (list "-s"
              "-C"
              base-dir
              (concat "CHK_SOURCES=" source)
               "SYNTAX_CHECK_MODE=1")))


;; specify that flymake use ant instead of make
(setcdr (assoc "\\.java\\'" flymake-allowed-file-name-masks)
        '(flymake-simple-ant-java-init flymake-simple-java-cleanup))

;; redefine to remove "check-syntax" target
(defun flymake-get-ant-cmdline (source base-dir)
  (list "ant"
        (list "-buildfile"
              (concat base-dir "/" "build.xml"))))

(add-hook 'java-mode-hook
          '(lambda ()
             (flymake-mode t)))


;;;;;;;;;;
; etc... ;
;;;;;;;;;;
;;; minibufferに表示
; growl使うので不要
;(defun credmp/flymake-display-err-minibuf ()
;  "Displays the error/warnings for the current line in the minubuffer"
;  (interactive)
;  (let* ((line-no (flymake-current-line-no))
;         (line-err-info-list (nth 0 (flymake-find-err-info flymake-err-info line-no)))
;        (count (length line-err-info-list))
;         )
;    (while (> count 0)
;      (when line-err-info-list
;        (let* ((file (flymake-ler-file (nth (1- count) line-err-info-list)))
;               (full-file (flymake-ler-full-file (nth (1- count) line-err-info-list)))
;               (text (flymake-ler-text (nth (1- count) line-err-info-list)))
;               (line (flymake-ler-line (nth (1- count) line-err-info-list))))
;          (message "[%s] %s" line text)
;          )
;        )
;      (setq count (1- count)))))

;; fringe-helper
(defvar flymake-fringe-overlays nil)
(make-variable-buffer-local 'flymake-fringe-overlays)
(defadvice flymake-make-overlay (after add-to-fringe first
                                       (beg end tooltip-text face mouse-face)
                                       activate compile)
  (push (fringe-helper-insert-region
           beg end
           (fringe-lib-load (if (eq face 'flymake-errline)
                                fringe-lib-exclamation-mark
                              fringe-lib-question-mark))
           'left-fringe 'my-flymake-warning-face)
           ;; 'left-fringe 'font-lock-warning-face)
        flymake-fringe-overlays))
(defadvice flymake-delete-own-overlays (after remove-from-fringe activate
                                              compile)
  (mapc 'fringe-helper-remove flymake-fringe-overlays)
  (setq flymake-fringe-overlays nil))





