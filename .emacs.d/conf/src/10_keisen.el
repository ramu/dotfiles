;;; 10_keisen.el ---
(global-set-key [S-right] 'keisen-right-move)
(global-set-key [S-left] 'keisen-left-move)
(global-set-key [S-up] 'keisen-up-move)
(global-set-key [S-down] 'keisen-down-move)

(autoload 'keisen-up-move "keisen" nil t)
(autoload 'keisen-down-move "keisen" nil t)
(autoload 'keisen-left-move "keisen" nil t)
(autoload 'keisen-right-move "keisen" nil t)

