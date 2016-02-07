;;;; 00_init.el
;; env
(setenv "EMACS" "t")
(setenv "RUBYLIB" "/Applications/Emacs.app/Contents/Resources/lib/ruby/site_ruby/")
(setenv "JAVA_HOME" "/Library/Java/Home")
(setenv "ANT_HOME" "/Library/Java/ant")
(setenv "NODE_PATH" "/usr/local/lib/node_modules")

;; load-path
(add-to-list 'load-path "~/.emacs.d/share/apel")
(add-to-list 'load-path "~/.emacs.d/share/slime")
(add-to-list 'load-path "~/.emacs.d/share/twittering-mode/")
(add-to-list 'load-path "~/.emacs.d/share/riece/")
(add-to-list 'load-path "~/.emacs.d/share/scala-mode")
(add-to-list 'load-path "~/.emacs.d/share/google-maps")
(add-to-list 'load-path "~/.emacs.d/share/Warp")
(add-to-list 'load-path "~/.emacs.d/share/plugins/magit/share/emacs/site-lisp")
(add-to-list 'load-path "/Applications/MacPorts/Emacs.app/Contents/Resource/lisp/w3m/")
(add-to-list 'load-path "~/scala/bin/")

;; path
(dolist (dirs (list
	       "/usr/bin/"
	       "/usr/sbin/"
	       "/sbin/"
	       "/usr/X11/bin/"
	       "/bin/"
	       "/usr/local/bin/"
	       "/opt/local/bin/"
	       (expand-file-name "~/bin/")
	       (expand-file-name "~/scala/bin/")
	       (expand-file-name "~/.pythonbrew/pythons/current/bin/")
	       (expand-file-name "~/perl5/perlbrew/bin/")
	       (expand-file-name "~/perl5/perlbrew/perls/current/bin/")
	       (expand-file-name "~/.rbenv/shims/")
	       (expand-file-name "~/.rbenv/bin/")))
  (when
      (setenv "PATH" (concat dirs ":" (getenv "PATH")))
       (setq exec-path (append (list dirs) exec-path))))
