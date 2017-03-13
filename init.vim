
" LOAD PLUGINS
" -----------------------------------------------
call plug#begin()




" MISCELLANEOUS
" -----------------------------------------------
" R plugin
Plug 'jalvesaq/Nvim-R'
" file system explorer
Plug 'tpope/vim-vinegar'




" EDITING
" ------------------------
" comment/uncomment
Plug 'tpope/vim-commentary'
" surround
Plug 'tpope/vim-surround'
" enable repeating
Plug 'tpope/vim-repeat'
" complementary pairs
Plug 'tpope/vim-unimpaired'




" APPEARANCE
" ------------------------
" show trailing whitespace
Plug 'ntpeters/vim-better-whitespace'
" color scheme
Plug 'mhartington/oceanic-next'




" SYNTAX HIGHLIGHTING
" ------------------------
" Plug 'wavded/vim-stylus'




" AUTOCOMPLETION
" ------------------------
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }




" SEARCH
" ------------------------
" highlight which characters to target for f, F and family
Plug 'gabrielflorit/quick-scope'
" make searching across lines easier/faster
Plug 'justinmk/vim-sneak'




" END PLUGINS
" -----------------------------------------------
call plug#end()




" APPEARANCE
" ----------------------------------------------

" use true colors
set termguicolors

" main color scheme
set background=dark

colorscheme OceanicNext

" tab settings
set tabstop=2 shiftwidth=2




" MISC
" -----------------------------------------------

" source vimrc on every write
autocmd bufwritepost init.vim source $MYVIMRC




" EDITING
" -----------------------------------------------

" use the general register for yanking
set clipboard+=unnamedplus




" AUTOCOMPLETION
" -----------------------------------------------

" Use deoplete.
let g:deoplete#enable_at_startup = 1

" Use tab to autocomplete and cycle through options.
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"




" REMAPS
" -----------------------------------------------

" remap leader to comma
let mapleader=','

" allow quit via single keypress (Q)
map Q :qa<CR>

" ,cp -> close preview
nnoremap <leader>pc :pc<CR>

" ,cc -> close location list
nnoremap <leader>cl :lcl<CR>

" ,cc -> close quickfix
nnoremap <leader>cq :ccl<CR>

" ,v -> edit vimrc
nmap <leader>v :tabedit $MYVIMRC<CR>

" ,w -> save
nnoremap <leader>w :w<CR>

" tab -> next buffer
nnoremap <Tab> :bnext<CR>

" shift-tab -> previous buffer
nnoremap <S-Tab> :bprevious<CR>
