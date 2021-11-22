set nocompatible	" Use Vim defaults (much better!)
set ai			" always set autoindenting on
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time

syntax on

set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set smartindent
set smarttab
set encoding=utf-8
set hlsearch

if has('mouse') 
	"set ttymouse=xterm2
	set mouse=a
endif

set wildmenu
set wildmode=list:longest,full
set incsearch
set smartcase
set ignorecase
set hidden
set foldmethod=manual

call plug#begin('~/.local/share/nvim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'albfan/ag.vim'
Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
call plug#end()

colorscheme gruvbox

augroup mdbindings
  autocmd! mdbindings
  autocmd Filetype markdown map <buffer> <silent> gf :e <cfile><CR>
augroup end

let g:blamer_enabled = 1
let g:blamer_delay = 200
let g:blamer_show_in_insert_modes = 0
let g:blamer_show_in_visual_modes = 0

let g:sessions_dir = '~/.vimsessions'
exec 'nnoremap <Leader>ss :mks! ' . g:sessions_dir . '/*.vim<C-D><BS><BS><BS><BS><BS>'
exec 'nnoremap <Leader>sr :so ' . g:sessions_dir. '/*.vim<C-D><BS><BS><BS><BS><BS>'

