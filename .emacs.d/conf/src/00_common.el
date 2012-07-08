;;; 00_common.el ---
(eval-when-compile (require 'cl))

;; when-require + message
; http://d.hatena.ne.jp/khiker/20091120/emacs_require_load_macro
(defmacro my-require-and-when (feature &rest body)
  (declare (indent 1))
  `(if (require ,feature nil t)
       (progn
         (message "Require success: %s" ,feature)
         ,@body)
     (message "Require error: %s" ,feature)))

(defmacro my-load-and-when (name &rest body)
  (declare (indent 1))
  `(if (load ,name t)
       (progn
         (message "Load success: %s" ,name)
         ,@body)
     (message "Load error: %s" ,name)))

(defmacro my-autoload-and-when (file name &rest body)
  (declare (indent 1))
  `(if (autoload ,file ,name t)
       (progn
         (message "autoLoad success: %s" ,file)
         ,@body)
     (message "autoLoad error: %s" ,file)))

(provide '00_common)