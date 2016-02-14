;;;; 01_frame.el
(require '00_common)

;; モードライン
(setq-default mode-line-format
  '("-"
    mode-line-mule-info
    mode-line-modified
    mode-line-frame-identification
    mode-line-buffer-identification
    (line-number-mode "(%l,")
    (column-number-mode "%c:")
    (-3 . "%p")
    ") "
    global-mode-string
    " %[("
    mode-name
    mode-line-process
    minor-mode-alist
    "%n" ")%]-"
    (which-func-mode ("" which-func-format "-"))
    (:eval (list (nyan-create)))
    "-%-"))
