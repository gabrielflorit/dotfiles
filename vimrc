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
set tabstop=2 shiftwidth=2				" a tab is four spaces
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

" Unite ecosystem
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/vimproc.vim'
Plugin 'rking/ag.vim'

" Appearance/colors/themes
Plugin 'chriskempson/base16-vim'
Plugin 'bling/vim-airline'
Plugin 'bling/vim-bufferline'

" Meta
Plugin 'takac/vim-hardtime'

" Search
Plugin 'justinmk/vim-sneak'
Plugin 'unblevable/quick-scope'

" Misc
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-commentary'
"Plugin 'mattn/emmet-vim'
Plugin 'moll/vim-bbye'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
"Plugin 'Raimondi/delimitMate'
"Plugin 'junegunn/vim-easy-align'
Plugin 'terryma/vim-multiple-cursors'
"Plugin 'jcfaria/Vim-R-plugin'

" " Autocomplete/snippets
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'marijnh/tern_for_vim'

" Syntax highlighting
Plugin 'scrooloose/syntastic'
Plugin 'wavded/vim-stylus'
Plugin 'othree/yajs.vim'
Plugin 'mxw/vim-jsx'
"" Plugin 'jelera/vim-javascript-syntax'
"" Plugin 'pangloss/vim-javascript'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'chase/vim-ansible-yaml'

" Git
Plugin 'tpope/vim-fugitive'

" Text objects
"Plugin 'gcmt/wildfire.vim'
Plugin 'kana/vim-textobj-user'
Plugin 'kana/vim-textobj-function'
Plugin 'kana/vim-textobj-indent'
Plugin 'thinca/vim-textobj-function-javascript'

call vundle#end()						" required
filetype plugin indent on				" load file type plugins + indentation

runtime macros/matchit.vim

let g:user_emmet_settings = {
    \  'html' : {
    \    'quote_char': "'",
    \  },
    \}

" }}}
" Unite ecosystem {{{

if executable('ag')
	" Use ag in unite grep source.
	let g:unite_source_grep_command = 'ag'
	let g:unite_source_grep_default_opts =
				\ '-i --vimgrep --hidden --ignore ' .
				\ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
	let g:unite_source_grep_recursive_opt = ''
elseif executable('pt')
	" Use pt in unite grep source.
	" https://github.com/monochromegane/the_platinum_searcher
	let g:unite_source_grep_command = 'pt'
	let g:unite_source_grep_default_opts = '--nogroup --nocolor'
	let g:unite_source_grep_recursive_opt = ''
elseif executable('ack-grep')
	" Use ack in unite grep source.
	let g:unite_source_grep_command = 'ack-grep'
	let g:unite_source_grep_default_opts =
				\ '-i --no-heading --no-color -k -H'
	let g:unite_source_grep_recursive_opt = ''
elseif executable('jvgrep')
	" For jvgrep.
	let g:unite_source_grep_command = 'jvgrep'
	let g:unite_source_grep_default_opts =
				\ '-i --exclude ''\.(git|svn|hg|bzr)'''
	let g:unite_source_grep_recursive_opt = '-R'
endif

" let g:unite_source_grep_command='ag'
" let g:unite_source_grep_default_opts='--nocolor --line-numbers --nogroup -S'
" let g:unite_source_grep_recursive_opt=''

" let g:unite_source_rec_async_command= 'ag --nocolor --nogroup --hidden -g ""'
" call unite#filters#matcher_default#use(['matcher_fuzzy'])
" call unite#custom#source('file_rec,file_rec/async', 'ignore_pattern', 'node_modules')

" }}}
" Syntastic {{{

let g:syntastic_javascript_checkers = ['jscs']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

au BufRead,BufNewFile *.es6 set ft=javascript

" }}}
" Autocompletion {{{

set completeopt-=preview				" no autocomplete preview window
autocmd FileType javascript setlocal omnifunc=tern#Complete

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
set nonumber							" disable line numbers

" }}}
" Custom functions {{{

if has("autocmd")						" source vimrc after saving
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

" }}}
" Statusline {{{

set laststatus=2						" always show statusline
let g:airline#extensions#default#layout = [
      \ [ 'a', 'b', 'c' ],
      \ [ 'z', 'warning' ]
      \ ]

" }}}
" R {{{

" let vimrplugin_applescript = 0

" }}}
" Remaps {{{

let mapleader=","						" leader to comma
nmap <leader>v :tabedit $MYVIMRC<CR>	" edit vimrc
nnoremap <leader>w :w<cr>				" save

" netrw: toggle
nnoremap <leader>n :Explore<cr>

" bbye: close buffer without closing window
nnoremap <leader>q :Bdelete<CR>

" ultisnips: edit snippets
nnoremap <leader>e :UltiSnipsEdit<cr>
nnoremap <leader>gt :Gcommit -v -q %:p<CR> " git add and commit this file
nnoremap <leader><leader> :Unite -start-insert -no-split file_rec/async:!<CR>
nnoremap <leader>f :Unite -no-split grep:.<CR>
nnoremap gp `[v`]						" select last changed text
nnoremap <Tab> :bnext<CR>				" next buffer
nnoremap <S-Tab> :bprevious<CR>			" previous buffer
let g:user_emmet_leader_key='<C-b>'		" emmet leader = b
nnoremap <silent> <esc> :noh<cr><esc>	" clear search highlight

" easyalign: start in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" easyalign: start interactive for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" }}}
" vim:foldmethod=marker:foldlevel=0
