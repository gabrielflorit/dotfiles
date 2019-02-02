" LOAD PLUGINS
" -----------------------------------------------
call plug#begin()



" MISCELLANEOUS
" -----------------------------------------------
" terminal utilities
" Plug 'kassio/neoterm'
" git
" Plug 'tpope/vim-fugitive'
" move .gitignore entries to vim wildignore
" Plug 'euclio/gitignore.vim'
" directory viewer
" Plug 'tpope/vim-vinegar'
Plug 'justinmk/vim-dirvish'
" use jk/kj instead of ESC
Plug 'zhou13/vim-easyescape'



" EDITING
" ------------------------
" comment/uncomment
Plug 'tpope/vim-commentary'
" surround
Plug 'tpope/vim-surround'
" enable repeating
Plug 'tpope/vim-repeat'



" APPEARANCE
" ------------------------
" show trailing whitespace
Plug 'ntpeters/vim-better-whitespace'
" color scheme
Plug 'joshdick/onedark.vim'


" SYNTAX HIGHLIGHTING
" ------------------------
" Stylus syntax highlighting
Plug 'wavded/vim-stylus'
Plug 'othree/yajs.vim'



" SEARCH
" ------------------------
" fzf vim commands
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" most-recently used files for fzf.vim
Plug 'tweekmonster/fzf-filemru'
" " highlight which characters to target for f, F and family
Plug 'unblevable/quick-scope'



" END PLUGINS
" -----------------------------------------------
call plug#end()




" APPEARANCE
" ----------------------------------------------

" use true colors
set termguicolors

" theme
colorscheme onedark

" color cursor red in terminal only
highlight TermCursor ctermfg=red guifg=red

" tab settings
set tabstop=2
set expandtab
set shiftwidth=2

" always show statusline
set laststatus=2

" show tab characters
set list
set listchars=tab:>-



" MISCELLANEOUS
" -----------------------------------------------

" ignore some things not in .gitignore
set wildignore+=.git,.git/*,yarn.lock



" FUNCTIONS
" -----------------------------------------------
function! DefaultWorkspace()
  " when moving to a terminal buffer, switch to insert mode
  autocmd BufEnter * if &buftype == 'terminal' | :startinsert | endif
  " when opening a terminal, switch to insert mode
  autocmd TermOpen * startinsert
endfunction

command! -register DefaultWorkspace call DefaultWorkspace()



" AUTOCMDS
" -----------------------------------------------
" Reloac vimrc on save.
" from https://vi.stackexchange.com/a/9099/7324
if has ('autocmd') " Remain compatible with earlier versions
  augroup vimrc " Source vim configuration upon save
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
  augroup END
endif " has autocmd

" unmap <Esc> in fzf buffers, so we can still use esc to close
autocmd FileType fzf tnoremap <buffer> <Esc> <Esc>



" REMAPS
" -----------------------------------------------

cnoremap jk <ESC>
cnoremap kj <ESC>

" remap leader to comma
let mapleader = ','

" allow quit via single keypress (Q)
map Q :qa<CR>

" ,v -> edit vimrc
nnoremap <leader>v :e $MYVIMRC<CR>

" use ctrl-[hjkl] to select the active split
tnoremap <S-h> <C-\><C-n><C-w>h
tnoremap <S-j> <C-\><C-n><C-w>j
tnoremap <S-k> <C-\><C-n><C-w>k
tnoremap <S-l> <C-\><C-n><C-w>l
nnoremap <S-h> <C-w>h
nnoremap <S-j> <C-w>j
nnoremap <S-k> <C-w>k
nnoremap <S-l> <C-w>l

" ,w -> save
nnoremap <leader>w :w<CR>

" ,x -> close
nnoremap <leader>x <c-w>q

" ,t -> open terminal
nnoremap <leader>t :edit term://fish<CR>

" close terminal with esc
tnoremap <Esc> <C-\><C-n>

" ,, -> search filenames
nnoremap <leader><leader> :FilesMru<CR>

" ,f -> search files with given string
nnoremap <leader>f :Ag<CR>
