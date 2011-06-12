;;; 10_smartchr.el --- 
(require 'smartchr)

(global-set-key (kbd "=") (smartchr '("=" " = " " == " "==")))
(global-set-key (kbd "!") (smartchr '("!" " != " "!!")))
(global-set-key (kbd "{") (smartchr '("{" "{`!!'}" "{{")))
(global-set-key (kbd "[") (smartchr '("[" "[`!!']" "[[")))
(global-set-key (kbd "<") (smartchr '("<" "<<" " <= " " =< ")))
(global-set-key (kbd ">") (smartchr '(">" ">>" " >= " " => "  " => '`!!''" " => \"`!!'\"")))
