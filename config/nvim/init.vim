" MAIN VIM CONFIG

" -----------------------------------------------
" General Settings
" -----------------------------------------------

syntax on

set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set smartindent
set smarttab
set encoding=utf-8
set hlsearch
set list

set nocompatible	" Use Vim defaults (much better!)
set ai			" always set autoindenting on
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time


set wildmenu
set wildmode=list:longest,full
set incsearch
set smartcase
set ignorecase
set hidden
set foldmethod=manual

set scrolloff=8
set sidescrolloff=8
set nojoinspaces

if has('mouse') 
	"set ttymouse=xterm2
	set mouse=a
endif


" -----------------------------------------------
" Key Maps
" -----------------------------------------------


let mapleader = "\<space>"

nmap <leader>ve :edit ~/.config/nvim/init.vim<cr>
nmap <leader>vr :source ~/.config/nvim/init.vim<cr>

map gf :edit <cfile><cr>


" -----------------------------------------------
" Plugins
" -----------------------------------------------

" Autoinstall vim-plug
" let data_dir

call plug#begin('~/.local/share/nvim/plugged')

source ~/.config/nvim/plugins/fzf.vim
source ~/.config/nvim/plugins/ag.vim
source ~/.config/nvim/plugins/vim-jsx-pretty.vim
source ~/.config/nvim/plugins/nvim-lspconfig.vim
source ~/.config/nvim/plugins/commentary.vim
source ~/.config/nvim/plugins/gruvbox.vim
source ~/.config/nvim/plugins/vim-airline.vim
source ~/.config/nvim/plugins/tabular.vim
source ~/.config/nvim/plugins/vim-markdown.vim

call plug#end()

lua require("lsp-config")
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
