;;;; 60_view.el ---
(require '00_common)

;;; pdf-preview.el
;; Emacs から、PDFファイルを作ってプレビュー
;; http://homepage.mac.com/matsuan_tamachan/emacs/PdfPreview.html
(my-require-and-when 'pdf-perview)

;;; viewer.el
;; View-mode extension
;; http://www.emacswiki.org/emacs/viewer.el
(my-require-and-when 'viewer
  (viewer-stay-in-setup)
  (setq viewer-modeline-color-unwritable "tomato"
        viewer-modeline-color-view "orange")
  (setq view-mode-by-default-regexp "/regexp-to-path")
  (viewer-change-modeline-color-setup)
  ;(viewer-aggressive-setup 'force)
  (defvar pager-keybind
        `( ;; vi-like
          ("h" . backward-word)
          ("l" . forward-word)
          ("j" . next-line)
          ("k" . previous-line)
          (";" . gene-word)
          ("b" . scroll-down)
          (" " . scroll-up)
          ;; w3m-like
          ("m" . gene-word)
          ("i" . win-delete-current-window-and-squeeze)
          ("w" . forward-word)
          ("e" . backward-word)
          ("(" . point-undo)
          (")" . point-redo)
          ("J" . ,(lambda () (interactive) (scroll-up 1)))
          ("K" . ,(lambda () (interactive) (scroll-down 1)))
          ;; bm-easy
          ("." . bm-toggle)
          ("[" . bm-previous)
          ("]" . bm-next)
          ;; langhelp-like
          ("c" . scroll-other-window-down)
          ("v" . scroll-other-window)))
  (defun define-many-keys (keymap key-table &optional includes)
    (let (key cmd)
      (dolist (key-cmd key-table)
        (setq key (car key-cmd)
              cmd (cdr key-cmd))
        (if (or (not includes) (member key includes))
          (define-key keymap key cmd))))
    keymap)
  (defun view-mode-hook0 ()
    (define-many-keys view-mode-map pager-keybind)
    (hl-line-mode 1)
    (define-key view-mode-map " " 'scroll-up))
  (add-hook 'view-mode-hook 'view-mode-hook0)
  ;; 書き込み不能なファイルはview-modeで開くように
  (defadvice find-file
    (around find-file-switch-to-view-file (file &optional wild) activate)
    (if (and (not (file-writable-p file))
             (not (file-directory-p file)))
        (view-file file)
      ad-do-it))
  ;; 書き込み不能な場合はview-modeを抜けないように
  (defvar view-mode-force-exit nil)
  (defmacro do-not-exit-view-mode-unless-writable-advice (f)
    `(defadvice ,f (around do-not-exit-view-mode-unless-writable activate)
       (if (and (buffer-file-name)
                (not view-mode-force-exit)
                (not (file-writable-p (buffer-file-name))))
           (message "File is unwritable, so stay in view-mode.")
         ad-do-it)))
  ;(defun viewer-mode-setting ()
  ;  (flymake-mode t))
  (setq view-read-only t)
  ;(add-hook 'view-mode-hook 'viewer-mode-setting)
  )
