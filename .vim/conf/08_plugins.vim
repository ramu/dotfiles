"---------------
" 08_plugins.vim
"---------------
" Neobundle
filetype off
if has('vim_starting')
   set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

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
NeoBundle 'Shougo/neosnippet'
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
NeoBundle 'vim-scripts/taglist.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tpope/vim-rails'

NeoBundle 'sudo.vim'
NeoBundle 'DirDiff.vim'
NeoBundle 'YankRing.vim'

call neobundle#end()

filetype plugin indent on

" Installation check.
if neobundle#exists_not_installed_bundles()
   echomsg 'Not installed bundles : ' .
            \ string(neobundle#get_not_installed_bundle_names())
   echomsg 'Please execute ":NeoBundleInstall" command.'
endif

" neocomplcache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_temporary_dir = '~/.vim/tmp/.neocomplcache'

" neosnippet
imap <C-k> <plug>(neosnippet_expand_or_jump)
smap <C-k> <plug>(neosnippet_expand_or_jump)
imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

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

" syntastic
let g:syntastic_enable_signs = 1
let g:syntastic_auto_loc_list = 2

" Tlist
let Tlist_Show_One_File = 1
let Tlist_Use_Right_Window = 1
let Tlist_Exit_OnlyWindows = 1

" unite
let g:unite_data_directory = '~/.vim/tmp/.unite'
