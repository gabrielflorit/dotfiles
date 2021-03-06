" LOAD PLUGINS
" -----------------------------------------------
call plug#begin()




" MISCELLANEOUS
" -----------------------------------------------
" git
Plug 'tpope/vim-fugitive'
" R plugin
Plug 'jalvesaq/Nvim-R'
" directory viewer
Plug 'tpope/vim-vinegar'
" terminal utilities
Plug 'kassio/neoterm'




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
" lint as you type
Plug 'w0rp/ale'
Plug 'chrisbra/NrrwRgn'




" APPEARANCE
" ------------------------
" show trailing whitespace
Plug 'ntpeters/vim-better-whitespace'
" color scheme
Plug 'mhartington/oceanic-next'
" colorize css colors
Plug 'ap/vim-css-color'




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
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" " most-recently used files for fzf.vim
Plug 'tweekmonster/fzf-filemru'
" highlight which characters to target for f, F and family
Plug 'bradford-smith94/quick-scope'
" make searching across lines easier/faster
Plug 'justinmk/vim-sneak'
"nd better asterisk search
Plug 'haya14busa/vim-asterisk'
" better incsearch
Plug 'haya14busa/incsearch.vim'




" END PLUGINS
" -----------------------------------------------
call plug#end()




" APPEARANCE
" ----------------------------------------------

let g:python3_host_prog = '/Users/floritg/.pyenv/versions/neovim3/bin/python'

" use true colors
set termguicolors

" color scheme
set background=dark
colorscheme OceanicNext

" color cursor red in terminal only
highlight TermCursor ctermfg=red guifg=red

" disable mru colors
let g:fzf_filemru_colors = {}

" tab settings
set tabstop=2
set expandtab
set shiftwidth=2

" always show statusline
set laststatus=2

" create statusline
set statusline=
" show git branch, e.g. [master], otherwise show empty string
set statusline+=%{strlen(fugitive#head())?'['.fugitive#head().']':''}
" display filename
set statusline+=\ %f
" if the file has been modified, display a +
set statusline+=%{&modified?'\ +':''}
" switch to the right-hand items
set statusline+=%=
" display current line number
set statusline+=\ %l
" display current line column
set statusline+=\ %c

" move R object browser to the left
let R_objbr_place="script,left"

" make neoterm use relative instead of absolute paths
let g:neoterm_use_relative_path=1
let g:neoterm_position='vertical'




" FUNCTIONS
" -----------------------------------------------

function! DplyrChains()
  let line = getline('.')
  " c => %>%
  if match(line, ' c$') > 0
    call setline('.', substitute(line, ' c$', ' %>%', 'e'))
    execute 'normal! $'
    " c => +
  elseif match(line, ' p$') > 0
    call setline('.', substitute(line, ' p$', ' +', 'e'))
    execute 'normal! $'
  endif
endfunction

function! DefaultWorkspace()
  " when moving to a terminal buffer, switch to insert mode
  autocmd BufEnter * if &buftype == 'terminal' | :startinsert | endif
  " when opening a terminal, switch to insert mode
  autocmd TermOpen * startinsert
endfunction

function! RLayout()
  silent! call StartR('R')
  silent! call RObjBrowser()
  wincmd l
  vertical resize 80
  call RmdNextChunk()
endfunction

function! GulpLayout()
  sp .
  wincmd j
  resize 10
  term gulp
endfunction

function! BlockLayout()
  sp .
  wincmd j
  resize 10
  term blockup
endfunction

function! RunBuffer()
  silent! call neoterm#clear()
  silent! call neoterm#do('node %')
endfunction

command! -register RLayout call RLayout()
command! -register BlockLayout call BlockLayout()
command! -register GulpLayout call GulpLayout()
command! -register DefaultWorkspace call DefaultWorkspace()




" AUTOCOMMANDS
" -----------------------------------------------

" unmap <Esc> in fzf buffers, so we can still use esc to close
autocmd FileType fzf tnoremap <buffer> <Esc> <Esc>

" set Rmd comment string
autocmd FileType rmd setlocal commentstring=#\ %s

" avoid typing %>% and +
autocmd FileType rmd inoremap <buffer> <CR> <C-O>:call DplyrChains()<CR><CR>




" EDITING
" -----------------------------------------------

set mouse=a

" use the general register for yanking
set clipboard+=unnamedplus

" show the effects of a command incrementally
set inccommand=nosplit

" disable automatic <- insertion in R
let R_assign = 0

" run checktime to force nvim to autoread buffers
set autoread
augroup improved_autoread
  autocmd!
  autocmd FocusGained * silent! checktime
  autocmd BufEnter * silent! checktime
augroup end

" don't run ALE lint continuously
let g:ale_lint_on_text_changed = 'never'

" don't run ALE lint on enter
let g:ale_lint_on_enter = 0

" dont' run ALE fix on save
let g:ale_fix_on_save = 0

" run ALE lint on save
let g:ale_lint_on_save = 1

" setup ALE to lint and fix with prettier_standard
let g:ale_linters = {'javascript': ['standard']}
let g:ale_fixers = {'javascript': ['prettier_standard']}

" " don't use the loclist
" let g:ale_set_loclist = 0
" " instead, use the quickfix
" let g:ale_set_quickfix = 1
" " and leave it open
" let g:ale_open_list = 1

" enable sneak to repeat by pressing s
let g:sneak#s_next = 1




" SEARCH
" -----------------------------------------------

" enable automatic :nohlsearch
let g:incsearch#auto_nohlsearch = 1




" AUTOCOMPLETION
" -----------------------------------------------

" Use deoplete.
let g:deoplete#enable_at_startup = 1

" Disable default snippets
let g:neosnippet#disable_runtime_snippets = {
  \ '_' : 1,
  \ }

" Use custom snippets
let g:neosnippet#snippets_directory='~/Documents/other/neosnippets'




" REMAPS
" -----------------------------------------------

" remap leader to comma
let mapleader = ','

" remap local leader to space
let maplocalleader = ' '

" allow quit via single keypress (Q)
map Q :qa<CR>

" configure vim-asterisk
map *   <Plug>(asterisk-z*)
map #   <Plug>(asterisk-z#)
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
nnoremap <leader>r :%s//gc<Left><Left><Left>

" ,t -> open terminal
nnoremap <leader>t :terminal<CR>

" ,gc -> git add and commit file
nnoremap <leader>gc :Gcommit -v -q %:p<CR>

" ,gp -> git push
nnoremap <leader>gp :Gpush<CR>

" improved ctrl-z
noremap <c-z> :suspend<cr>:silent! checktime<cr>

" ,l -> lint
nnoremap <leader>al :ALELint<CR>
nnoremap <leader>af :ALEFix<CR>

" ,tt -> run buffer in node
nnoremap <silent> <leader>tt :call RunBuffer()<CR>
