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
	set mouse=a
endif

set wildmenu
set incsearch
set smartcase
set ignorecase
set hidden
set foldmethod=manual

call plug#begin('~/.local/share/nvim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'albfan/ag.vim'
call plug#end()

augroup mdbindings
  autocmd! mdbindings
  autocmd Filetype markdown map <buffer> <silent> gf :e <cfile><CR>
augroup end
