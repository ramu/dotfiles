;;;; 50_android.el
(require '00_common)

;;; android-mode.el
(my-require-and-when 'android-mode
  (setq android-mode-sdk-dir (expand-file-name "~/Android/android-sdk-mac_x86")))
