;============================================================
; shell-toggle-patched.el
; http://gihyo.jp/admin/seriial/01/ubuntu-recipe/0038?page=1
;============================================================

(require 'shell-toggle)

(autoload 'shell-toggle "shell-toggle"
 "Toggles between the *shell* buffer and whatever buffer you are editing." t)
(autoload 'shell-toggle-cd "shell-toggle"
 "Pops up a shell-buffer and insert a \"cd <file-dir>\" command." t)
(global-set-key "\C-ct" 'shell-toggle)
(global-set-key "\C-cd" 'shell-toggle-cd)

(add-hook 'term-mode-hook '(lambda ()
                               (define-key term-raw-map "\C-z"
                               (lookup-key (current-global-map) "\C-z"))))

