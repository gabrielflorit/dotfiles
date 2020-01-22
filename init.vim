" LOAD PLUGINS
" -----------------------------------------------
call plug#begin()



" MISCELLANEOUS
" -----------------------------------------------
" git
Plug 'tpope/vim-fugitive'
" directory viewer
Plug 'justinmk/vim-dirvish'
" helpers for unix
Plug 'tpope/vim-eunuch'
" use jk/kj instead of ESC
Plug 'zhou13/vim-easyescape'



" EDITING
" ------------------------
" complementary pairs
Plug 'tpope/vim-unimpaired'
" comment/uncomment
Plug 'tpope/vim-commentary'
" surround
Plug 'tpope/vim-surround'
" enable repeating
Plug 'tpope/vim-repeat'
" lint as you type
Plug 'w0rp/ale'



" APPEARANCE
" ------------------------
" show trailing whitespace
Plug 'ntpeters/vim-better-whitespace'
" color scheme
Plug 'joshdick/onedark.vim'



" SYNTAX HIGHLIGHTING
" ------------------------
" Stylus syntax highlighting
Plug 'wavded/vim-stylus'
" JavaScript syntax highlighting
Plug 'yuezk/vim-js'
" JSX syntax highlighting
Plug 'maxmellon/vim-jsx-pretty'
" MDX syntax highlighting
Plug 'jxnblk/vim-mdx-js'



" SEARCH
" ------------------------
" fzf vim commands
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Most-recently used files for fzf.vim
Plug 'tweekmonster/fzf-filemru'
" Highlight which characters to target for f, F and family
Plug 'unblevable/quick-scope'
" Better asterisk search
Plug 'haya14busa/vim-asterisk'
" Better incsearch
Plug 'haya14busa/incsearch.vim'



" AUTOCOMPLETION
" ------------------------
" Asynchronous completion framework
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Enable snippets
Plug 'Shougo/neosnippet.vim'



" END PLUGINS
" -----------------------------------------------
call plug#end()



" FUNCTIONS
" -----------------------------------------------
function! DefaultWorkspace()
  " when moving to a terminal buffer, switch to insert mode
  autocmd BufEnter * if &buftype == 'terminal' | :startinsert | endif
  " when opening a terminal, switch to insert mode
  autocmd TermOpen * startinsert
endfunction

function! LinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))

  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  return l:counts.total == 0 ? '' : printf(
  \   ' %dW %dE',
  \   all_non_errors,
  \   all_errors
  \)
endfunction



" APPEARANCE
" ----------------------------------------------

" use true colors
set termguicolors

" theme
colorscheme onedark

" color cursor red in terminal only
highlight TermCursor ctermfg=red guifg=red

" don't wrap
set nowrap

" tab settings
set tabstop=2
set expandtab
set shiftwidth=2

" always show statusline
set laststatus=2

" show tab characters
set list
set listchars=tab:>-

" create statusline
set statusline=
" show git branch, e.g. [master], otherwise show empty string
set statusline+=%{strlen(fugitive#head())?'['.fugitive#head().']':''}
" display filename
set statusline+=\ %f
" if the file has been modified, display a +
set statusline+=%{&modified?'\ +':''}
set statusline+=%{LinterStatus()}
" switch to the right-hand items
set statusline+=%=
" display current line number
set statusline+=\ %l
" display current line column
set statusline+=\ %c



" MISCELLANEOUS
" -----------------------------------------------

" ignore some things not in .gitignore
set wildignore+=.git,.git/*,yarn.lock,.DS_Store,node_modules,build,LICENSE

set foldmethod=indent
set foldcolumn=0
set foldlevel=99
" let javaScript_fold=1
" set foldlevelstart=99



" AUTOCMDS
" -----------------------------------------------
" Reloac vimrc on save.
" from https://vi.stackexchange.com/a/9099/7324
if has ('autocmd') " Remain compatible with earlier versions
  augroup vimrc " Source vim configuration upon save
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
  augroup END
endif " has autocmd

" unmap <Esc> in fzf buffers, so we can still use esc to close
autocmd FileType fzf tnoremap <buffer> <Esc> <Esc>

command! -register DefaultWorkspace call DefaultWorkspace()



" EDITING
" -----------------------------------------------

" run ALE lint on enter
let g:ale_lint_on_enter = 1

" always show the gutter
let g:ale_sign_column_always = 1

" run ALE fix on save
let g:ale_fix_on_save = 1

" run ALE lint on save
let g:ale_lint_on_save = 1

" use global eslint because that's what eslint_d likes
let g:ale_javascript_eslint_use_global = 1

" use eslint_d instead of eslint - it's MUCH faster
let g:ale_javascript_eslint_executable = 'eslint_d'
let g:ale_linters = {'javascript': ['eslint']}
let g:ale_fixers = {'javascript': ['prettier']}

" make ale use quickfix instead of loclist
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1

" open quickfix on errors
let g:ale_open_list = 1

" run checktime to force nvim to autoread buffers
set autoread
augroup improved_autoread
autocmd!
autocmd FocusGained * silent! checktime
autocmd BufEnter * silent! checktime
augroup end

augroup dirvish_config
  autocmd!
  autocmd FileType dirvish silent! unmap <buffer> <S-k>
augroup END



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



" SEARCH
" -----------------------------------------------
set hlsearch
set incsearch

" Enable automatic :nohlsearch
let g:incsearch#auto_nohlsearch = 1



" REMAPS
" -----------------------------------------------

cnoremap jk <ESC>
cnoremap kj <ESC>

" remap leader to comma
let mapleader = ','

" allow quit via single keypress (Q)
map Q :qa<CR>

" ,v -> edit vimrc
nnoremap <leader>v :e $MYVIMRC<CR>

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

" use ctrl-[hjkl] to select the active split
tnoremap <S-h> <C-\><C-n><C-w>h
tnoremap <S-j> <C-\><C-n><C-w>j
tnoremap <S-k> <C-\><C-n><C-w>k
tnoremap <S-l> <C-\><C-n><C-w>l
nnoremap <S-h> <C-w>h
nnoremap <S-j> <C-w>j
nnoremap <S-k> <C-w>k
nnoremap <S-l> <C-w>l

" ,w -> save
nnoremap <leader>w :w<CR>

" ,x -> close
nnoremap <leader>x <c-w>q

" ,t -> open terminal
nnoremap <leader>t :edit term://fish<CR>

" close terminal with esc
tnoremap <Esc> <C-\><C-n>

" ,, -> search filenames
nnoremap <leader><leader> :FilesMru<CR>

" ,f -> search files with given string
nnoremap <leader>f :Ag<CR>

" tab -> next buffer
nnoremap <Tab> :bnext<CR>

" shift-tab -> previous buffer
nnoremap <S-Tab> :bprevious<CR>

" ,gc -> git add and commit file
nnoremap <leader>gc :Gcommit -v -q %:p<CR>

" ,gp -> git push
nnoremap <leader>gp :Gpush<CR>

" improved ctrl-z
noremap <c-z> :suspend<cr>:silent! checktime<cr>

" esc esc -> clear search highlight
nnoremap <silent> <Esc><Esc> :noh<CR> :call clearmatches()<CR>

imap <expr><tab> neosnippet#expandable_or_jumpable()
  \ ? "\<Plug>(neosnippet_expand_or_jump)"
  \ : (pumvisible() ? "\<C-n>" : "\<tab>")

" ,r -> highlight search and replace matches
nnoremap <leader>r :%s//gc<Left><Left><Left>

" ,cq -> close quickfix
nnoremap <leader>cq :ccl<CR>

nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf
