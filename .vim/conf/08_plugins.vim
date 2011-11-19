"---------------
" 08_plugins.vim
"---------------
" Neobundle
filetype off
set rtp+=~/.vim/neobundle/
call neobundle#rc()

NeoBundle 'corntrace/bufexplorer'
NeoBundle 'houtsnip/vim-emacscommandline'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-textobj-fold'
NeoBundle 'kana/vim-textobj-indent'
NeoBundle 'kana/vim-textobj-lastpat'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'mattn/zencoding-vim'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'taku-o/vim-toggle'
NeoBundle 'taku-o/vim-ro-when-swapfound'
NeoBundle 'thinca/vim-ref'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'ujihisa/quickrun'
NeoBundle 'vim-scripts/buftabs'

NeoBundle 'sudo.vim'
NeoBundle 'DirDiff.vim'
NeoBundle 'YankRing.vim'

filetype plugin indent on

" neocomplcache
let g:neocomplcache_enable_at_startup = 1
imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" vimproc
let g:vimproc_dll_path = $HOME."/.vim/autoload/proc.so"

" vimshell
let g:VimShell_enableinteractive = 1

" vimfiler
let g:vimfiler_as_default_explorer = 1

" buftabs
let buftabs_only_basename = 1
let buftabs_in_statusline = 1

" matchit
:runtime macros/matchit.vim

" YankRing
let g:yankring_history_dir = $HOME."/log/"
