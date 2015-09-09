" LOAD PLUGINS
" -----------------------------------------------
call plug#begin()

" normalize.css for vim
Plug 'tpope/vim-sensible'

" color scheme
Plug 'yosiat/oceanic-next-vim'

" status line
Plug 'bling/vim-bufferline'
Plug 'bling/vim-airline'

" neomake - asynchronous make
Plug 'benekastah/neomake'

" comment/uncomment motion
Plug 'tpope/vim-commentary'

" syntax highlighting
" Plug 'pangloss/vim-javascript'
Plug 'othree/yajs.vim'

" git
Plug 'tpope/vim-fugitive'

" buffer closing utility
Plug 'moll/vim-bbye'

call plug#end()



" APPEARANCE
" ----------------------------------------------

" change cursor shape to pipe on insert mode
:let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" main color scheme
colorscheme OceanicNext

" tab settings
set tabstop=2 shiftwidth=2

" always show statusline
set laststatus=2

" don't show vim mode
set noshowmode

" don't echo bufferline to statusline
let g:bufferline_echo = 0

" don't show buffer numbers in bufferline
let g:bufferline_show_bufnr = 0

" use patched powerline fonts in statusline
let g:airline_powerline_fonts = 1

" specify statusline colorscheme
let g:airline_theme='oceanicnext'

" disable statusline block separators
let g:airline_left_sep=''
let g:airline_right_sep=''

" customize what blocks we show in statusline
let g:airline#extensions#default#layout = [
	\ [ 'a', 'b', 'c' ],
	\ [ 'z', 'warning' ]
	\ ]



" CODE CHECKING
" -----------------------------------------------

" fire Neomake on every write
autocmd! BufWritePost * Neomake

" tell Neomake we want to run jscs for javascript files
let g:neomake_javascript_enabled_makers=['jscs']



" MISC
" -----------------------------------------------

" source vimrc on every write
autocmd bufwritepost .nvimrc source $MYVIMRC



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

" F7 -> syntax off / syntax enable
:map <F7> :if exists("g:syntax_on") <Bar>
	\   syntax off <Bar>
	\ else <Bar>
	\   syntax enable <Bar>
	\ endif <CR>
