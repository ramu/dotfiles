;; 10_gneve.el
(defvar gneve-mode-map nil
  "local keymap for gneve")

;;(setq gneve-mode-map nil)

(if gneve-mode-map
    nil
  (setq gneve-mode-map (make-sparse-keymap))
  (define-key gneve-mode-map "\C-k" 'next-frame)
  (define-key gneve-mode-map "\C-l" 'pause)
  (define-key gneve-mode-map "\C-q" 'one-sec-back)
  (define-key gneve-mode-map "\C-w" 'one-sec-forward)
  (define-key gneve-mode-map "\C-e" 'mark-start)
  (define-key gneve-mode-map "\C-r" 'mark-end)
  (define-key gneve-mode-map "H" 'write-marks))
 
(defun gneve-mode()
  "EDL and mplayer based GNU Emacs video editing mode"
  (interactive)
  (start-process "my-process" "boo" "/Application/Mplayer OS X 2.app/Contents/MacOS/MPlayer\ OS\ X\ 2" "-edlout" "/root/test.edl" "-slave" "-quiet"  "/root/possession.avi")
  (pop-to-buffer "*GNEVE*" nil)
  (kill-all-local-variables)
  (setq major-mode 'gneve-mode)
  (setq mode-name "gneve")
  (use-local-map gneve-mode-map))

(defun next-frame ()
  (interactive)
  (process-send-string "my-process" "frame_step\n"))

(defun pause ()
  (interactive)
  (process-send-string "my-process" "pause\n"))

(defun write-marks ()
  ;; copy/write both last-in and last-out to end of gneve buffer
  (interactive)
  (switch-to-buffer "*GNEVE*")
(goto-char (point-max))

(insert (format "%s %s" lastin lastout)))

(defun one-sec-back ()
  (interactive)
  (process-send-string "my-process" "seek -0.5\n"))

(defun one-sec-forward ()
  (interactive)
  (process-send-string "my-process" "seek 0.1\n"))

(defun mark-start ()
  ;; copies latest mark to boo. copy and paste only to variable - new function write to buffer
  (interactive)
(progn
  ;; goto end of buffer search back to equals and copy to last-in
  (switch-to-buffer-other-window "boo")
  (process-send-string "my-process" "pausing get_time_pos\n")
  (sleep-for 0.1)
  (goto-char (point-max))
  (backward-char)
  (backward-char)
  (setq end (point))
  (search-backward "=")
  ;; one char forward
  (forward-char)
  (setq start (point))
  (copy-region-as-kill start end)
  (setq lastin (car kill-ring))
  (switch-to-buffer-other-window "*GNEVE*")))

(defun mark-end ()
  ;; copies latest mark to boo. copy and paste only to variable - new function write to buffer
  (interactive)
(progn
  ;; goto end of buffer search back to equals and copy to last-in
  (switch-to-buffer-other-window "boo")
  (process-send-string "my-process" "pausing get_time_pos\n")
  (sleep-for 0.1)
  (goto-char (point-max))
  (backward-char)
  (backward-char)
  (setq end (point))
  (search-backward "=")
  ;; one char forward
  (forward-char)
  (setq start (point))
  (copy-region-as-kill start end)
  (setq lastout (car kill-ring))
  (switch-to-buffer-other-window "*GNEVE*")))

