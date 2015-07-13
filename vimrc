" General {{{
"" Basic
set nocompatible						" choose no compatibility with legacy vi
syntax enable							" enable syntax
set encoding=utf-8						" set encoding to utf-8
set showcmd								" display incomplete commands
set modelines=1							" check final line of this file for a modeline
let g:hardtime_default_on=1				" enable hardtime
set hidden								" allow more than one buffer per split
set noerrorbells visualbell t_vb=		" no beeping
autocmd GUIEnter * set visualbell t_vb=	" no beeping
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
Plugin 'mattn/emmet-vim'
Plugin 'bling/vim-airline'
Plugin 'bling/vim-bufferline'
Plugin 'moll/vim-bbye'
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
call vundle#end()						" required
filetype plugin indent on				" load file type plugins + indentation
" }}}
" Autocompletion {{{
function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            call UltiSnips#JumpForwards()
            if g:ulti_jump_forwards_res == 0
               return "\<TAB>"
            endif
        endif
    endif
    return ""
endfunction

au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-e>"
" this mapping Enter key to <C-y> to chose the current highlight item 
" and close the selection list, same as other IDEs.
" CONFLICT with some plugins like tpope/Endwise
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" }}}
" Appearance {{{
set background=light					" set light colorscheme
colorscheme base16-solarized			" use solarized
set guifont=Ubuntu\ Mono:h20			" set font and size
set guioptions=egm						" gvim options (no scrollbars, etc)
set relativenumber						" show relative numbers
set number								" show line numbers
set laststatus=2						" always show statusline
" }}}
" Custom functions {{{
if has("autocmd")						" source vimrc after saving
  autocmd bufwritepost .vimrc source $MYVIMRC
endif
" }}}
" Remaps {{{
let mapleader=","						" leader to comma
nmap <leader>v :e $MYVIMRC<CR>	" edit vimrc
nnoremap <leader>w :w<cr>				" save
nnoremap <leader>n :Explore<cr>			" toggle netrw
let g:user_emmet_leader_key='<C-b>'		" emmet leader = b
nnoremap <Tab> :bnext<CR>				" next buffer
nnoremap <S-Tab> :bprevious<CR>			" previous buffer
nnoremap <leader>q :Bdelete<CR>			" close buffer without closing window
nnoremap <leader>e :UltiSnipsEdit<cr>	" edit snippets
" }}}
" vim:foldmethod=marker:foldlevel=0
