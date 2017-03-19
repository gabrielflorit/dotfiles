
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
" Stylus syntax highlighting
Plug 'wavded/vim-stylus'




" AUTOCOMPLETION
" ------------------------
" Asynchronous completion framework
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Enable snippets
Plug 'Shougo/neosnippet.vim'




" SEARCH
" ------------------------
" highlight which characters to target for f, F and family
Plug 'gabrielflorit/quick-scope'
" make searching across lines easier/faster
Plug 'justinmk/vim-sneak'
" better asterisk search
Plug 'haya14busa/vim-asterisk'
" better incsearch
Plug 'haya14busa/incsearch.vim'




" END PLUGINS
" -----------------------------------------------
call plug#end()




" APPEARANCE
" ----------------------------------------------

" use true colors
set termguicolors

" color scheme
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




" SEARCH
" -----------------------------------------------

" set hlsearch

" enable automatic :nohlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)




" AUTOCOMPLETION
" -----------------------------------------------

" Use deoplete.
let g:deoplete#enable_at_startup = 1

" Disable default snippets
let g:neosnippet#disable_runtime_snippets = {
			\   '_' : 1,
			\ }

" Use custom snippets
let g:neosnippet#snippets_directory='~/Documents/other/neosnippets'

" If there is a snippet, expand it.
" Otherwise if there is an autocompletion, use it.
" Otherwise use tab.
imap <expr><tab> neosnippet#expandable()
			\ ? "\<Plug>(neosnippet_expand_or_jump)"
			\ : (pumvisible() ? "\<C-n>" : "\<tab>")




" EVENTS
" -----------------------------------------------

:au BufEnter * if &buftype == 'terminal' | :startinsert | endif




" REMAPS
" -----------------------------------------------

" remap leader to comma
let mapleader=','

" allow quit via single keypress (Q)
map Q :qa<CR>

" configure vim-asterisk
map *  <Plug>(asterisk-z*)
map #  <Plug>(asterisk-z#)
map g*  <Plug>(asterisk-gz*)
map g#  <Plug>(asterisk-gz#)

" configure incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" use ctrl-[hjkl] to select the active split

" nmap <silent> <c-k> :wincmd k<CR>
" nmap <silent> <c-j> :wincmd j<CR>
" nmap <silent> <c-h> :wincmd h<CR>
" nmap <silent> <c-l> :wincmd l<CR>

" tnoremap <C-h> <C-\><C-n><C-h>
" tnoremap <C-j> <C-\><C-n><C-j>
" tnoremap <C-k> <C-\><C-n><C-k>
" tnoremap <C-l> <C-\><C-n><C-l>

:tnoremap <C-h> <C-\><C-n><C-w>h
:tnoremap <C-j> <C-\><C-n><C-w>j
:tnoremap <C-k> <C-\><C-n><C-w>k
:tnoremap <C-l> <C-\><C-n><C-w>l
:nnoremap <C-h> <C-w>h
:nnoremap <C-j> <C-w>j
:nnoremap <C-k> <C-w>k
:nnoremap <C-l> <C-w>l

" ,cp -> close preview
nnoremap <leader>pc :pc<CR>

" ,cc -> close location list
nnoremap <leader>cl :lcl<CR>

" ,cc -> close quickfix
nnoremap <leader>cq :ccl<CR>

" ,v -> edit vimrc
nnoremap <leader>v :tabedit $MYVIMRC<CR>

" ,w -> save
nnoremap <leader>w :w<CR>

" tab -> next buffer
nnoremap <Tab> :bnext<CR>

" shift-tab -> previous buffer
nnoremap <S-Tab> :bprevious<CR>

" ,ne -> edit this filetype's snippets
nnoremap <leader>ne :NeoSnippetEdit<CR>

" esc esc -> clear search highlight
nnoremap <silent> <Esc><Esc> :noh<CR> :call clearmatches()<CR>




" LAYOUT
" -----------------------------------------------
function! DefaultLayout()

	vnew
	e .
	vnew
	e .
	wincmd l
	wincmd l
	sp .
	wincmd j
	e term://zsh
	resize 10

endfunction
command! -register DefaultLayout call DefaultLayout()
