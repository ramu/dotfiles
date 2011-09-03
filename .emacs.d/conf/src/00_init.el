;; 00_init.el
;; env
(setenv "EMACS" "t")
(setenv "RUBYLIB" "/Applications/Emacs.app/Contents/Resources/lib/ruby/site_ruby/")
(setenv "JAVA_HOME" "/Library/Java/Home")
(setenv "ANT_HOME" "/Library/Java/ant")

;; load-path
(add-to-list 'load-path "~/.emacs.d/elisp/apel")
(add-to-list 'load-path "~/work/git/twittering-mode/")
(add-to-list 'load-path "~/.emacs.d/auto-install/")
(add-to-list 'load-path "~/.emacs.d/elisp/riece/")
(add-to-list 'load-path "~/.emacs.d/elisp/scala-mode")
(add-to-list 'load-path "~/.emacs.d/elisp/google-maps")
(add-to-list 'load-path "~/.emacs.d/plugins/magit/share/emacs/site-lisp")
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
                "/Users/ramusara/scala/bin/"
                "/Users/ramusara/.pythonbrew/pythons/current/bin/"
                "/Users/ramusara/perl5/perlbrew/bin/"
                "/Users/ramusara/perl5/perlbrew/perls/current/bin/"))
(when
   (setenv "PATH" (concat dirs ":" (getenv "PATH")))
   (setq exec-path (append (list dirs) exec-path))))
