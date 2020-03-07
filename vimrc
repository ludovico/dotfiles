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

noremap <C-l> <C-w>l
noremap <C-k> <C-w>k
noremap <C-j> <C-w>j
noremap <C-h> <C-w>h
cmap w!! w !sudo tee % > /dev/null

" Latexinstillinger

filetype plugin indent on
set grepprg=grep\ -nH\ $*
filetype indent on
let g:tex_fllavor='latex'

" let g:year = system('echo -n "$YEAR"')
" let g:module = system('echo -n "$MODULE"')
" command! -nargs=1 Nack Ack -i --text --nohtml "<args>" $NOTES_DIR/*/*/*.txt
" command! -nargs=1 Note exe "e! " . fnameescape($NOTES_DIR . "/MS". g:year . "/mod" . g:module . "/<args>.txt")
" 
" nnoremap <leader>[ :Nls 
" nnoremap <leader>] :Note 
" 
" augroup markdown
"    au!
"    au BufNewFile,BufRead,BufWrite *.txt,*.md,*.mkd,*.markdown,*.mdwn setl ft=markdown
"    au BufRead,BufNewFile,BufEnter   */mod*/*.md let &complete="k$NOTES_DIR/**/*.md"
"    au BufRead,BufNewFile,BufEnter   */mod*/*.md lcd %:h
"    au BufRead,BufWrite,InsertChange */mod*/*.md syn match ErrorMsg '\%>77v.\+'
" augroup end
" 
call plug#begin()
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'mileszs/ack.vim'
Plug 'leafgarland/typescript-vim'
call plug#end()
color dracula
