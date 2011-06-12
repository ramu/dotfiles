;;; 10_cpp-complt.el --- 
(require 'cpp-complt)

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
        ;; glib
        "/usr/local/include/glib-2.0"
        ;; gtk-2.0
        "/usr/local/include/gtk-2.0"
        ;; boost
        "/opt/local/include/boost/"))

