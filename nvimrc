if (has("termguicolors"))
 set termguicolors
endif

" LOAD PLUGINS
" -----------------------------------------------
call plug#begin()



" MISCELLANEOUS
" ------------------------
" git
Plug 'tpope/vim-fugitive'
" buffer closing utility
Plug 'moll/vim-bbye'
" disable arrow keys, disable key spamming
Plug 'takac/vim-hardtime'
" file system explorer
Plug 'tpope/vim-vinegar'
" asynchronous make
Plug 'benekastah/neomake'
" test runner
Plug 'janko-m/vim-test'



" APPEARANCE
" ------------------------
" color scheme
" Plug 'chriskempson/base16-vim'
" status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" show trailing whitespace
Plug 'ntpeters/vim-better-whitespace'
Plug 'mhartington/oceanic-next'



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
" better incsearch
Plug 'haya14busa/incsearch.vim'
" fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
" fzf.vim
Plug 'junegunn/fzf.vim'
" fzf mru plugin
Plug 'tweekmonster/fzf-filemru'
" highlight which characters to target for f, F and family
Plug 'unblevable/quick-scope'
" highlight searches in command line window
Plug 'osyo-manga/vim-over'
Plug 'dkprice/vim-easygrep'



" SYNTAX HIGHLIGHTING
" ------------------------
Plug 'mustache/vim-mustache-handlebars'
Plug 'rschmukler/pangloss-vim-indent'
Plug 'othree/yajs.vim'
Plug 'mxw/vim-jsx'
Plug 'wavded/vim-stylus'
Plug 'digitaltoad/vim-pug'



" TEXT OBJECTS
" ------------------------
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-function'
Plug 'thinca/vim-textobj-function-javascript'



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

colorscheme OceanicNext

" tab settings
set tabstop=2 shiftwidth=2

" always show statusline
set laststatus=2

" don't show vim mode
set noshowmode

" use patched powerline fonts in statusline
let g:airline_powerline_fonts = 1

" specify statusline colorscheme
let g:airline_theme='oceanicnext'
" let g:loaded_airline_themes=1

" disable statusline block separators
let g:airline_left_sep=''
let g:airline_right_sep=''

" customize what blocks we show in statusline
let g:airline#extensions#default#layout = [
			\ [ 'a', 'b', 'c' ],
			\ [ 'z', 'warning' ]
			\ ]

" enable italicised comments
highlight Comment cterm=italic



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

" source vimrc on every write
autocmd bufwritepost init.vim source $MYVIMRC

let test#strategy = 'neovim'
let g:test#javascript#mocha#executable = 'node_modules/.bin/mocha --compilers js:babel-core/register'

" use ~ to toggle cases
function! TwiddleCase(str)
	if a:str ==# toupper(a:str)
		let result = tolower(a:str)
	elseif a:str ==# tolower(a:str)
		let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
	else
		let result = toupper(a:str)
	endif
	return result
endfunction
vnoremap ~ y:call setreg('', TwiddleCase(@"), getregtype(''))<CR>gv""Pgv

" " defer ultisnips loading
" augroup load_us
" 	autocmd!
" 	autocmd InsertEnter * call plug#load('ultisnips') | call UltiSnips#FileTypeChanged() | autocmd! load_us
" augroup END



" SEARCH
" -----------------------------------------------

" highlight search results
set hlsearch

" tell fzf to use ag. it will respect .gitignore
let $FZF_DEFAULT_COMMAND = 'ag -l -g ""'

" enable automatic :nohlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

let g:fzf_filemru_bufwrite = 1



" SYNTAX HIGHLIGHTING
" -----------------------------------------------
let g:jsx_ext_required=0

let g:neomake_list_height = 2
let g:neomake_open_list = 2
let g:neomake_verbose = 3
let g:neomake_javascript_eslint_exe = './node_modules/.bin/eslint_d'
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_jsx_enabled_makers = ['eslint']
autocmd! BufWritePost *.js silent! Neomake




" AUTOCOMPLETION
" -----------------------------------------------

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion   = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType    = '<C-n>'
let g:ycm_autoclose_preview_window_after_insertion = 1

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger       = '<tab>'
let g:UltiSnipsJumpForwardTrigger  = '<Right>'
let g:UltiSnipsJumpBackwardTrigger = '<Left>'




" REMAPS
" -----------------------------------------------

" remap leader to comma
let mapleader=','

map 0 ^

" configure vim-asterisk
map *  <Plug>(asterisk-z*)
map #  <Plug>(asterisk-z#)
map g* <Plug>(asterisk-gz*)
map g# <Plug>(asterisk-gz#)

" configure incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" get past an nvim-specific bug https://github.com/neovim/neovim/issues/2048#issuecomment-78045837
if has('nvim')
	nmap <BS> <C-W>h
endif

" use ctrl-[hjkl] to select the active split
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" allow quit via single keypress (Q)
map Q :qa<CR>

" ,cp -> close preview
nnoremap <leader>pc :pc<CR>

" ,cc -> close location list
nnoremap <leader>cl :lcl<CR>

" ,cc -> close quickfix
nnoremap <leader>cq :ccl<CR>

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
nnoremap <leader><leader> :FilesMru<CR>

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

" ,tt -> run test on current file
nmap <silent> <leader>tt :TestFile<CR>

" ,t -> run test nearest to cursor
nmap <silent> <leader>t :TestNearest<CR>

nmap <silent> <leader>l :Neomake<CR>
