set encoding=utf-8

" dein config start ========================================================
if &compatible
  set nocompatible
endif

" Directory of dein.vim
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" git clone dein if doesnt exist
if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif
execute 'set runtimepath^=' . s:dein_repo_dir

" plugins
let s:toml = '~/.dein.toml'
let s:lazy_toml = '~/.dein_lazy.toml'

if dein#load_state(s:dein_dir) || dein#load_state(s:toml) || dein#load_state(s:lazy_toml)
  call dein#begin(s:dein_dir)
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif

" vimproc should be installed first
if dein#check_install(['vimproc'])
  call dein#install(['vimproc'])
endif

" others
if dein#check_install()
  call dein#install()
endif

" dein config end ==========================================================


" general settings =========================================================
" enable backspace
set backspace=indent,eol,start

colorscheme monokai
syntax enable

" show line number 
set number

" status ===================================================================
set laststatus=2
set statusline=%=\ %l/%L,\ %03c\ [%Y]

" share clipboad with Mac ==================================================
set clipboard+=unnamed

" neocomplete settings
let g:neocomplete#enable_at_startup = 1
 
inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <S-Tab> <C-p>

" tab settings =============================================================
" tab size
set tabstop=2 

" replace tab with spaces
set expandtab

" auto-indent size
set shiftwidth=2

" QuickRun settings ========================================================
" quickrun config of Haskell
let g:quickrun_config = {}
let g:quickrun_config._ = {
\ 'outputter/buffer/split': 'vertical rightbelow 30',
\}
"\ 'outputter/buffer/split' : ':botright 8sp',
" runner" : vimproc",
let g:quickrun_config.haskell = {
\ 'command' : 'stack',
\ 'exec' : '%c %o %s %a',
\ 'cmdopt' : 'runghc',
\}

let g:quickrun_config.javascript = {
\ 'command' : 'node',
\ 'exec' : '%c %s',
\}

" For Syntastic ============================================================
execute pathogen#infect()
syntax on
filetype plugin indent on

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Nginx syntax settings ====================================================
au BufRead,BufNewFile /etc/nginx/* set ft=nginx
au Bufread,BufNewFile */nginx*conf set ft=nginx

