" LOAD PLUGINS
" -----------------------------------------------
call plug#begin()

" MISCELLANEOUS
" ------------------------
" normalize.css for vim
Plug 'tpope/vim-sensible'
" git
Plug 'tpope/vim-fugitive'
" buffer closing utility
Plug 'moll/vim-bbye'



" APPEARANCE
" ------------------------
" color scheme
Plug 'yosiat/oceanic-next-vim'
Plug 'chriskempson/base16-vim'
" " status line
" Plug 'bling/vim-bufferline'
Plug 'bling/vim-airline'



" EDITING
" ------------------------
" comment/uncomment
Plug 'tpope/vim-commentary'
" surround
Plug 'tpope/vim-surround'



" SEARCH
" ------------------------
" better asterisk search
Plug 'haya14busa/vim-asterisk'
" fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'



" SYNTAX HIGHLIGHTING
" ------------------------
" Plug 'pangloss/vim-javascript'
Plug 'mustache/vim-mustache-handlebars'
Plug 'othree/yajs.vim'

call plug#end()



" APPEARANCE
" ----------------------------------------------

" main color scheme
set background=dark

" colorscheme OceanicNext
colorscheme base16-default

" tab settings
set tabstop=2 shiftwidth=2

" always show statusline
set laststatus=2

" don't show vim mode
set noshowmode

" " don't echo bufferline to statusline
" let g:bufferline_echo = 0

" " don't show buffer numbers in bufferline
" let g:bufferline_show_bufnr = 0

" use patched powerline fonts in statusline
let g:airline_powerline_fonts = 1

" specify statusline colorscheme
let g:airline_theme='base16'

" disable statusline block separators
let g:airline_left_sep=''
let g:airline_right_sep=''

" customize what blocks we show in statusline
let g:airline#extensions#default#layout = [
	\ [ 'a', 'b', 'c' ],
	\ [ 'z', 'warning' ]
	\ ]



" " CODE CHECKING
" " -----------------------------------------------



" MISC
" -----------------------------------------------

" source vimrc on every write
autocmd bufwritepost .vimrc source $MYVIMRC



" " SEARCH
" " -----------------------------------------------

" configure vim-asterisk
map *  <Plug>(asterisk-z*)
map #  <Plug>(asterisk-z#)
map g* <Plug>(asterisk-gz*)
map g# <Plug>(asterisk-gz#)

let $FZF_DEFAULT_COMMAND = 'ag -l -g ""'



" REMAPS
" -----------------------------------------------

" remap leader to comma
let mapleader=','

" ,v -> edit vimrc
nmap <leader>v :tabedit $MYVIMRC<CR>

" ,w -> save
nnoremap <leader>w :w<CR>

" ,n -> toggle netrw
nnoremap <leader>n :Explore<CR>

" tab -> next buffer
nnoremap <Tab> :bnext<CR>

" shift-tab -> previous buffer
nnoremap <S-Tab> :bprevious<CR>

" close buffer without closing window
nnoremap <leader>q :Bdelete<CR>

" esc -> clear search highlight
nnoremap <silent> <esc> :noh<cr><esc>

" git add and commit file
nnoremap <leader>gt :Gcommit -v -q %:p<CR>

" ,, -> search filenames
nnoremap <leader><leader> :FZF<CR>

" ,f -> search files with given string
nnoremap <leader>f :Ag<CR>
