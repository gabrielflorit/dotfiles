" LOAD PLUGINS
call plug#begin()

" normalize.css for vim
Plug 'tpope/vim-sensible'

" color scheme
Plug 'yosiat/oceanic-next-vim'

" neomake - asynchronous make
Plug 'benekastah/neomake'

call plug#end()



" COLORS
colorscheme OceanicNext



" CODE CHECKING
autocmd! BufWritePost * Neomake
let g:neomake_javascript_enabled_makers = ['jscs']
