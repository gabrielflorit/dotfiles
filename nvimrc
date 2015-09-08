" LOAD PLUGINS
" -----------------------------------------------
call plug#begin()

" normalize.css for vim
Plug 'tpope/vim-sensible'

" color scheme
Plug 'yosiat/oceanic-next-vim'
Plug 'bling/vim-bufferline'
Plug 'bling/vim-airline'

" neomake - asynchronous make
Plug 'benekastah/neomake'

" comment/uncomment motion
Plug 'tpope/vim-commentary'

" syntax highlighting
Plug 'pangloss/vim-javascript'

" git
Plug 'tpope/vim-fugitive'

call plug#end()



" APPEARANCE
" ----------------------------------------------

" color scheme
colorscheme OceanicNext

" tab settings
set tabstop=2 shiftwidth=2

" always show statusline
set laststatus=2

" configure airline
let g:airline#extensions#default#layout = [
      \ [ 'a', 'b', 'c' ],
      \ [ 'z', 'warning' ]
      \ ]

" use powerline fonts
let g:airline_powerline_fonts = 1


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

" F7 -> syntax off / syntax enable
:map <F7> :if exists("g:syntax_on") <Bar>
	\   syntax off <Bar>
	\ else <Bar>
	\   syntax enable <Bar>
	\ endif <CR>
