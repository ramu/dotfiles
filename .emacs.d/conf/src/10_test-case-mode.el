;;; 10_test-case-mode.el ---
(autoload 'test-case-mode "test-case-mode" nil t)
(autoload 'enable-test-case-mode-if-test "test-case-mode")
(autoload 'test-case-find-all-tests "test-case-mode" nil t)
(autoload 'test-case-compilation-finish-run-all "test-case-mode")
(require 'test-case-pynose)

(add-hook 'find-file-hook 'enable-test-case-mode-if-test)
(add-hook 'compilation-finish-function 'test-case-compilation-finish-run-all)
(add-hook 'after-save-hook 'test-case-run)

