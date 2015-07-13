" General {{{
"" Basic
set nocompatible						" choose no compatibility with legacy vi
syntax enable							" enable syntax
set encoding=utf-8						" set encoding to utf-8
set showcmd								" display incomplete commands
set modelines=1							" check final line of this file for a modeline
let g:hardtime_default_on=1				" enable hardtime
set hidden								" allow more than one buffer per split

"" Whitespace
set nowrap								" don't wrap lines
set tabstop=4 shiftwidth=4				" a tab is four spaces
set backspace=indent,eol,start			" backspace through everything in insert mode

"" Searching
set hlsearch							" highlight matches
set incsearch							" incremental searching
set ignorecase							" searches are case insensitive...
set smartcase							" ... unless they contain at least one capital letter
" }}}
" Plugins {{{
filetype off							" required
set rtp+=~/.vim/bundle/Vundle.vim		" set the runtime path to include Vundle
call vundle#begin()						" initialize Vundle
Plugin 'gmarik/Vundle.vim'				" let Vundle manage Vundle, required
Plugin 'chriskempson/base16-vim'
Plugin 'takac/vim-hardtime'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-commentary'
call vundle#end()						" required
filetype plugin indent on				" load file type plugins + indentation
" }}}
" Appearance {{{
set background=light					" set light colorscheme
colorscheme base16-solarized			" use solarized
set guifont=Ubuntu\ Mono:h20			" set font and size
set guioptions=egm						" gvim options (no scrollbars, etc)
set relativenumber						" show relative numbers
set number								" show line numbers
" }}}
" Custom functions {{{
if has("autocmd")						" source vimrc after saving
  autocmd bufwritepost .vimrc source $MYVIMRC
endif
" }}}
" Remaps {{{
let mapleader=","						" leader to comma
nmap <leader>v :tabedit $MYVIMRC<CR>	" edit vimrc
nnoremap <leader>w :w<cr>				" save
nnoremap <leader>n :E<cr>				" toggle netrw
" }}}
" vim:foldmethod=marker:foldlevel=0
