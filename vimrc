" LOAD PLUGINS
" -----------------------------------------------
call plug#begin()

Plug 'gabrielflorit/js-syntax-vim'

" MISCELLANEOUS
" ------------------------
" normalize.css for vim
Plug 'tpope/vim-sensible'
" git
Plug 'tpope/vim-fugitive'
" buffer closing utility
Plug 'moll/vim-bbye'
Plug 'takac/vim-hardtime'



" APPEARANCE
" ------------------------
" color scheme
Plug 'chriskempson/base16-vim'
" status line
Plug 'bling/vim-bufferline'
Plug 'bling/vim-airline'
Plug 'ntpeters/vim-better-whitespace'



" EDITING
" ------------------------
" comment/uncomment
Plug 'tpope/vim-commentary'
" surround
Plug 'tpope/vim-surround'
" easy align
Plug 'junegunn/vim-easy-align'
" auto close xml tags
Plug 'alvan/vim-closetag'
" auto insert or delete brackets, parens, quotes in pair
Plug 'jiangmiao/auto-pairs'



" SEARCH
" ------------------------
" better asterisk search
Plug 'haya14busa/vim-asterisk'
" fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'
Plug 'unblevable/quick-scope'



" SYNTAX HIGHLIGHTING
" ------------------------
" Plug 'pangloss/vim-javascript'
Plug 'mustache/vim-mustache-handlebars'
Plug 'othree/yajs.vim'
Plug 'wavded/vim-stylus'



" TEXT OBJECTS
" ------------------------
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'



" AUTOCOMPLETION
" ------------------------
Plug 'Valloric/YouCompleteMe'



call plug#end()



" APPEARANCE
" ----------------------------------------------

" vertical bar in insert mode
let &t_SI = "\<Esc>]50;CursorShape=1\x7"

" block in normal mode
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" main color scheme
set background=dark

" colorscheme OceanicNext
colorscheme base16-oceanicnext

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
let g:airline_theme='base16'

" disable statusline block separators
let g:airline_left_sep=''
let g:airline_right_sep=''

" customize what blocks we show in statusline
let g:airline#extensions#default#layout = [
	\ [ 'a', 'b', 'c' ],
	\ [ 'z', 'warning' ]
	\ ]

" highlight search results
set hlsearch



" EDITING
" -----------------------------------------------

" enable autoclose tag on xml files
let g:closetag_filenames = "*.html,*.hbs"

" enable mustache abbreviations
let g:mustache_abbreviations = 1

" enable matchit
runtime macros/matchit.vim



" MISC
" -----------------------------------------------

" enable hardtime
let g:hardtime_default_on = 1

" enable mouse
set mouse=a

" source vimrc on every write
autocmd bufwritepost .vimrc source $MYVIMRC

" use ctrl-[hjkl] to select the active split
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" allow quit via single keypress (Q)
map Q :qa<CR>



" SEARCH
" -----------------------------------------------

" configure vim-asterisk
map *  <Plug>(asterisk-z*)
map #  <Plug>(asterisk-z#)
map g* <Plug>(asterisk-gz*)
map g# <Plug>(asterisk-gz#)

" tell fzf to use ag. it will respect .gitignore
let $FZF_DEFAULT_COMMAND = 'ag -l -g ""'



" AUTOCOMPLETION
" -----------------------------------------------



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

" ,q -> close buffer without closing window
nnoremap <leader>q :Bdelete<CR>

" esc esc -> clear search highlight
nnoremap <silent> <Esc><Esc> :noh<CR> :call clearmatches()<CR>

" ,gt -> git add and commit file
nnoremap <leader>gt :Gcommit -v -q %:p<CR>

" ,, -> search filenames
nnoremap <leader><leader> :FZF<CR>

" ,f -> search files with given string
nnoremap <leader>f :Ag<CR>

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
