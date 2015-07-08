" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype off

" Tell YouCompleteMe which python to use
let g:ycm_path_to_python_interpreter = '/usr/bin/python'
 
" set the runtime path to include Vundle and initialize
set rtp+=~/Documents/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/vimproc.vim'
Plugin 'takac/vim-hardtime'
Plugin 'chriskempson/base16-vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'

" All of your Plugins must be added before the following line
call vundle#end()            " required

" Enable file type detection and do language-dependent indenting.
filetype plugin indent on

" Allow hidden buffers, don't limit to 1 file per window/split
set hidden

" Switch syntax highlighting on
syntax enable

" Set solarized
set background=light
colorscheme base16-solarized

" Show line numbers
set relativenumber
set number

" Make backspace behave in a sane manner.
set backspace=indent,eol,start

" Remap leader key
let mapleader=","

" Easy vimrc editing
nmap <leader>v :tabedit $MYVIMRC<CR>

" Source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

" Set font and size
set guifont=Ubuntu\ Mono:h20

" Set tabstops every 4 spaces
set tabstop=4

" Set indent amount every 4 spaces
set shiftwidth=4

" Unite settings
let g:unite_source_rec_async_command= 'ag --nocolor --nogroup --hidden -g ""'
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#custom#source('file_rec,file_rec/async', 'ignore_pattern', 'node_modules')
nnoremap <Leader>f :Unite -start-insert -no-split file_rec/async:!<CR>

" Enable hardtime
let g:hardtime_default_on=1

" Configure YouCompleteMe
let g:ycm_key_list_select_completion = ['<Down>', '<Enter>']
let g:ycm_min_num_of_chars_for_completion = 3

" Fast save shortcut
nnoremap <leader>w :w<cr>

" Fast window switching
nnoremap <leader>b <c-w>w

" UltiSnips trigger configuration
" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"