"-----------------
" 05_templates.vim
"-----------------
" Emacsと共用
autocmd BufNewFile *.sh 0r $HOME/.emacs.d/share/templates/template.sh
autocmd BufNewFile *.c 0r $HOME/.emacs.d/share/templates/template.c
autocmd BufNewFile *.h 0r $HOME/.emacs.d/share/templates/template.h
autocmd BufNewFile *.cc 0r $HOME/.emacs.d/share/templates/template.cc
autocmd BufNewFile *.hpp 0r $HOME/.emacs.d/share/templates/template.hpp
autocmd BufNewFile *.html 0r $HOME/.emacs.d/share/templates/template.html
autocmd BufNewFile *.pl 0r $HOME/.emacs.d/share/templates/template.pl
autocmd BufNewFile *.py 0r $HOME/.emacs.d/share/templates/template.py
