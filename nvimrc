" LOAD PLUGINS
call plug#begin()

" normalize.css for vim
Plug 'tpope/vim-sensible'

" color scheme
Plug 'chriskempson/base16-vim'

" neomake - asynchronous make
Plug 'benekastah/neomake'

call plug#end()



" COLORS
"set background=dark
"colorscheme base16-solarized



" CODE CHECKING
autocmd! BufWritePost * Neomake
let g:neomake_javascript_enabled_makers = ['jscs']
