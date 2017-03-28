
" LOAD PLUGINS
" -----------------------------------------------
call plug#begin()




" MISCELLANEOUS
" -----------------------------------------------
" git
Plug 'tpope/vim-fugitive'
" R plugin
Plug 'jalvesaq/Nvim-R'
" file system explorer
Plug 'tpope/vim-vinegar'
" buffer closing utility
Plug 'moll/vim-bbye'




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
" fzf vim commands
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
" most-recently used files for fzf.vim
Plug 'tweekmonster/fzf-filemru'
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

" color cursor red in terminal only
highlight TermCursor ctermfg=red guifg=red

" disable mru colors
let g:fzf_filemru_colors = {}




" FUNCTIONS
" -----------------------------------------------

function! DplyrChains()

	let line = getline('.')

	if match(line, ' c$') > 0
		call setline('.', substitute(line, ' c$', ' %>%', 'e'))
		execute 'normal! $'
	endif

endfunction

	" " enforce good habits
	" execute '.s/ +$/ wrong/e'
	" execute '.s/ %>%$/ wrong/e'
	" " swap c/p at end of line with %>%/+
	" execute '.s/ c$/ %>%/e'
	" execute '.s/ p$/ +/e'

function! DefaultWorkspace()

	autocmd BufEnter * if &buftype == 'terminal' | :startinsert | endif

endfunction




" AUTOCOMMANDS
" -----------------------------------------------

" unmap <Esc> in fzf buffers, so we can still use esc to close
autocmd FileType fzf tnoremap <buffer> <Esc> <Esc>

" set Rmd comment string
autocmd FileType rmd setlocal commentstring=#\ %s

" avoid typing %>% and +
inoremap <CR> <C-O>:call DplyrChains()<CR><CR>

" autocmd FileType rmd inoremap <buffer> <expr> <CR> match(getline('.'), ' c$') >= 0 ? '<CR>' : '<CR>'

" autocmd FileType rmd inoremap <buffer> <expr> <CR> match(getline('.'), ' c$') >= 0 ? :call DplyrSnippet() : '<CR>'
" autocmd FileType rmd inoremap <buffer> <expr> <CR> match(getline('.'), ' c$') >= 0 ? '<CR><Esc>:call DplyrSnippet()<CR><CR>' : '<CR>'
" autocmd FileType rmd inoremap <buffer> <CR> <ESC>:call DplyrSnippet()<CR>

" autocmd FileType rmd inoremap <buffer> <CR> y:call DplyrSnippet()<CR>

" vnoremap ~ y:call setreg('', TwiddleCase(@"), getregtype(''))<CR>gv""Pgv



" EDITING
" -----------------------------------------------

" use the general register for yanking
set clipboard+=unnamedplus

" show the effects of a command incrementally
set inccommand=nosplit

" disable automatic <- insertion in R
let R_assign = 0




" SEARCH
" -----------------------------------------------

" enable automatic :nohlsearch
let g:incsearch#auto_nohlsearch = 1

" tell fzf to use ag. it will respect .gitignore
let $FZF_DEFAULT_COMMAND = 'ag -l -g ""'




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




" COMMANDS
" -----------------------------------------------

command! -register DefaultWorkspace call DefaultWorkspace()




" REMAPS
" -----------------------------------------------

" remap leader to comma
let mapleader = ','

" remap local leader to space
let maplocalleader = ' '

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

" turn hlsearch off after searching-related motions
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)

" close terminal with esc
tnoremap <Esc> <C-\><C-n>

" use ctrl-[hjkl] to select the active split
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" ,cp -> close preview
nnoremap <leader>pc :pc<CR>

" ,cc -> close location list
nnoremap <leader>cl :lcl<CR>

" ,cc -> close quickfix
nnoremap <leader>cq :ccl<CR>

" ,v -> edit vimrc
nnoremap <leader>v :e $MYVIMRC<CR>

" ,w -> save
nnoremap <leader>w :w<CR>

" ,q -> close buffer without closing window
nnoremap <leader>q :Bdelete<CR>

" tab -> next buffer
nnoremap <Tab> :bnext<CR>

" shift-tab -> previous buffer
nnoremap <S-Tab> :bprevious<CR>

" ,ne -> edit this filetype's snippets
nnoremap <leader>ne :NeoSnippetEdit<CR>

" tab -> If there is a snippet, expand it.
" Otherwise if there is an autocompletion, use it.
" Otherwise use tab.
imap <expr><tab> neosnippet#expandable()
			\ ? "\<Plug>(neosnippet_expand_or_jump)"
			\ : (pumvisible() ? "\<C-n>" : "\<tab>")

" esc esc -> clear search highlight
nnoremap <silent> <Esc><Esc> :noh<CR> :call clearmatches()<CR>

" ,, -> search filenames
nnoremap <leader><leader> :FilesMru<CR>

" ,f -> search files with given string
nnoremap <leader>f :Ag<CR>

" ,r -> highlight search and replace matches
nnoremap <leader>r :%s//g<Left><Left>

" ,t -> open terminal
nnoremap <leader>t :terminal<CR>

" ,gc -> git add and commit file
nnoremap <leader>gc :Gcommit -v -q %:p<CR>
