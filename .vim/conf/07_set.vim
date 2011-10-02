"-----------
" 07_set.vim
"-----------
set encoding=utf-8
set nocompatible
set textwidth=0
set autoread
set number
set ruler
set showmatch
set showcmd
set showmode
set smartcase
set nowrap
set hidden
set formatoptions=lmoq
set vb t_vb=
set guioptions+=a

" search
set wrapscan
set ignorecase
set smartcase
set incsearch
set hlsearch
set grepformat=%f:%l:%m,%f:%l%m,%f\ \ %l%m,%f
set grepprg=grep\ -n

" clipboard
set clipboard+=autoselect

" mouse
set mouse=a
set ttymouse=xterm2

" window
set laststatus=2
set statusline=%=\[%{(&fenc!=''?&fenc:&enc)}/%{&ff}]\[%03l,%03v]
let g:buftabs_active_highlight_group="Visual"
