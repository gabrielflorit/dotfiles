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
" disable arrow keys, disable key spamming
Plug 'takac/vim-hardtime'
" file system explorer
Plug 'tpope/vim-vinegar'



" APPEARANCE
" ------------------------
" color scheme
Plug 'chriskempson/base16-vim'
" show list of buffers in command line
Plug 'bling/vim-bufferline'
" status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" show trailing whitespace
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
Plug 'rstacruz/vim-closer'
" enable repeating
Plug 'tpope/vim-repeat'
" complementary pairs
Plug 'tpope/vim-unimpaired'
" autoformat
Plug 'Chiel92/vim-autoformat'



" SEARCH
" ------------------------
" better asterisk search
Plug 'haya14busa/vim-asterisk'
" fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'
" highlight which characters to target for f, F and family
Plug 'unblevable/quick-scope'
" highlight searches in command line window
Plug 'osyo-manga/vim-over'
" clever f - use f/F instead of ;/,
Plug 'rhysd/clever-f.vim'



" SYNTAX HIGHLIGHTING
" ------------------------
Plug 'mustache/vim-mustache-handlebars'
Plug 'pangloss/vim-javascript'
" Plug 'othree/yajs.vim'
Plug 'mxw/vim-jsx'
Plug 'wavded/vim-stylus'
" Plug 'lambdatoast/elm.vim'
Plug 'ElmCast/elm-vim'



" TEXT OBJECTS
" ------------------------
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'



" AUTOCOMPLETION
" ------------------------
Plug 'ervandew/supertab'
Plug 'Valloric/YouCompleteMe'
Plug 'SirVer/ultisnips'



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
" let g:loaded_airline_themes=1

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

" clever f: search only in current line
let g:clever_f_across_no_line = 1



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
let g:list_of_normal_keys = ["h", "j", "k", "l", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
" let g:hardtime_ignore_buffer_patterns = ["netrw"]

" enable mouse
set mouse=a

" source vimrc on every write
autocmd bufwritepost .vimrc source $MYVIMRC

" interface with system clipboard directly
set clipboard=unnamed



" SEARCH
" -----------------------------------------------

" tell fzf to use ag. it will respect .gitignore
let $FZF_DEFAULT_COMMAND = 'ag -l -g ""'



" SYNTAX HIGHLIGHTING
" -----------------------------------------------
let g:jsx_ext_required=0



" AUTOCOMPLETION
" -----------------------------------------------

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion   = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType    = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger       = '<tab>'
let g:UltiSnipsJumpForwardTrigger  = '<Right>'
let g:UltiSnipsJumpBackwardTrigger = '<Left>'



" ELM
" -----------------------------------------------

" make elm compile to index.html
let g:elm_make_output_file = 'index.html'

" make elm make you fix warnings
let g:elm_make_show_warnings = 1

" on save run elm-make on Main.elm
" :au BufWritePost *.elm silent! ElmMakeMain ElmFormat
" :au BufWritePost *.elm silent! ElmFormat
:au BufWritePost *.elm ElmFormat
:au BufWritePost *.elm ElmMakeMain

" let g:elm_format_autosave = 1

" REMAPS
" -----------------------------------------------

" remap leader to comma
let mapleader=','

" map semicolon to colon in normal mode
nmap ; :

" configure vim-asterisk
map *  <Plug>(asterisk-z*)
map #  <Plug>(asterisk-z#)
map g* <Plug>(asterisk-gz*)
map g# <Plug>(asterisk-gz#)

" use ctrl-[hjkl] to select the active split
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" allow quit via single keypress (Q)
map Q :qa<CR>

" ,cp -> close preview
nnoremap <leader>pc :pc<CR>

" ,cc -> close quickfix
nnoremap <leader>cc :ccl<CR>

" ,vs -> split window vertically
noremap <leader>vs :vs<CR>

" ,v -> edit vimrc
nmap <leader>v :tabedit $MYVIMRC<CR>

" ,w -> save
nnoremap <leader>w :w<CR>

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
nnoremap <leader>gp :Gpush<CR>
nnoremap <leader>gs :Gstatus<CR>

" ,, -> search filenames
nnoremap <leader><leader> :FZF<CR>

" ,f -> search files with given string
nnoremap <leader>f :Ag<CR>

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Y -> yank from cursor to end of line
map Y y$

" ,e -> UltiSnipsEdit
nnoremap <leader>ue :UltiSnipsEdit<CR>

" ,r -> highlight search and replace matches
nnoremap <leader>r :OverCommandLine<CR>%s//gc<Left><Left><Left>

" " ,b -> elm-make on current file
" au FileType elm nmap <leader>b <Plug>(elm-make)

" " ,m -> elm-make on Main.elm
" au FileType elm nmap <leader>m <Plug>(elm-make-main)

" ,d -> elm-show-docs
au FileType elm nmap <leader>d <Plug>(elm-show-docs)

" ,e -> elm-error-detail
au FileType elm nmap <leader>e <Plug>(elm-error-detail)

" ,b -> elm-browse-docs
au FileType elm nmap <leader>b <Plug>(elm-browse-docs)

" au FileType elm nmap <leader>t <Plug>(elm-test)
" au FileType elm nmap <leader>r <Plug>(elm-repl)
