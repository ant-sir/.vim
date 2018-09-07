" vim: fdm=marker ts=2 sts=2 sw=2 fdl=0

set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set fileencoding=utf-8

set number
set smarttab cindent
let &tabstop=4
let &softtabstop=4
let &shiftwidth=4
set hlsearch ignorecase smartcase incsearch
set list
set listchars=tab:│\ ,trail:•,extends:❯,precedes:❮
set shiftround
set linebreak
let &showbreak='↪ '

set showmatch
set showcmd

set nofoldenable

set lazyredraw

set scrolloff=5
set sidescrolloff=7
set sidescroll=1

set display+=lastline

" use pipe
set noshelltemp

set autoread

set backspace=indent,eol,start

if !has('gui_running')
  set t_Co=256
endif

if has('win32') || has('win64')
  set runtimepath+=~/.vim
  set wildignore+=*\\.git\\*,*\\.hg\\*,*\\.svn\\*,*\\*.si4project\\*
else
  set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/*.si4project/*
endif

" enable cursorline
set cursorline

" for ☆
" set ambiwidth=double

call plug#begin('~/.vim/plugged')

Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeCWD'] }
if has('unix')
  Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': ['NERDTreeToggle', 'NERDTreeCWD'] }
endif
Plug 'w0rp/ale'
Plug 'airblade/vim-gitgutter'
Plug 'kien/ctrlp.vim'
Plug 'majutsushi/tagbar', { 'on': ['TagbarToggle', 'TagbarOpen'] }
Plug 'valloric/youcompleteme'
Plug 'scrooloose/nerdcommenter'
if executable('ag')
  Plug 'mileszs/ack.vim'
endif

call plug#end()

let mapleader = ","
let g:mapleader = ","

if has('gui_running')
  "set background=light
  set background=dark
else
  set background=dark
endif

colorscheme solarized

if has('gui_running')
  set guioptions-=m  "remove menu bar
  set guioptions-=T  "remove toolbar
  set guioptions-=r  "remove right-hand scroll bar
  set guioptions-=L  "remove left-hand scroll bar

  set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h12:cANSI
endif

"sync with OS clipboard
if exists('$TMUX')
    set clipboard=
  else
    set clipboard=unnamed
endif

autocmd BufEnter * if 0 == len(filter(range(1, winnr('$')), 'empty(getbufvar(winbufnr(v:val), "&bt"))')) | qa! | endif

" for ctrlp do not clear cache on exit
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_max_files = 0

" for vim-airline
let g:airline_powerline_fonts = 1


" for nerdtree
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'


" How can I open NERDTree automatically when vim starts up on opening a directory?
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif


" go back to previous position of cursor if any
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \  exe 'normal! g`"zvzz' |
  \ endif

" map for change from windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

inoremap <C-h> <left>
inoremap <C-k> <up>
inoremap <C-j> <down>
inoremap <C-l> <right>

" cancel search hight
nmap <leader><cr> :noh<cr>

" find current word in quickfix
nnoremap <C-g>w :execute "vimgrep! ".expand("<cword>")." %"<cr>:copen<cr>
" find last search in quickfix
nnoremap <C-g>l :execute 'vimgrep! /'.@/.'/g %'<cr>:copen<cr>

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
  command! -nargs=+ Ag :call SearchForAg("<args>")
  cnoreabbrev ag Ag
  nmap <C-g>f :call SearchForAg("<cword>")<CR>
  nmap <C-g>s :call SearchVisualSelection()<CR>
endif

nmap <C-g>$ :call StripTrailingWhitespace()<CR>

let g:quickfix_open_flag = 0
nmap <F2> :call QuickFixToggle()<CR>


if executable('gtags')
  let g:Gtags_No_Auto_Jump = 1
  nmap <leader><leader>f :GtagsCursor<CR>
  nmap <leader><leader>d :call GtagsGoToDefine("<cword>")<CR>
  nmap <leader><leader>r :execute 'Gtags -r '.expand("<cword>")<CR>
  nmap <F12> :GtagsUpdate<CR>
endif

" How can I map a specific key or shortcut to open NERDTree?
map <F8> :NERDTreeToggle<CR>
map <C-F8> :NERDTreeCWD<CR>

" map <F9> for Tagbar
let g:tagbarflag = 0
nnoremap <silent> <F9> :call TagbarToggleFunc()<CR>

function! QuickFixToggle() abort
  if g:quickfix_open_flag == 0
    let g:quickfix_open_flag = 1
    execute 'copen'
  else
    let g:quickfix_open_flag = 0
    execute 'cclose'
  endif
endfunction

function! Preserve(command) "{{{
  " preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " do the business:
  execute a:command
  " clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction "}}}

function! StripTrailingWhitespace() "{{{
  call Preserve("%s/\\s\\+$//e")
endfunction "}}}

function! SearchForAg(string) abort
  let saved_shellpipe = &shellpipe
  let &shellpipe = '>'
  try
    execute 'Ack!' shellescape(a:string, 1)
  finally
    let &shellpipe = saved_shellpipe
  endtry
endfunction

function! TagbarToggleFunc() abort
  if g:tagbarflag == 0
    execute 'TagbarOpen fj'
    let g:tagbarflag = 1
  else
    let g:tagbarflag = 0
    execute 'TagbarToggle'
  endif
endfunction

function! GetVisualSelection() abort
  let [lineSelection, colSelection] = getpos('v')[1:2]
  let [lineCursor, colCursor] = getpos('.')[1:2]

  " Swap line numbers if selection starts at cursor
  let [lineStart, lineEnd] = (lineSelection <= lineCursor) ? [lineSelection, lineCursor] : [lineCursor, lineSelection]

  let lines = getline(lineStart, lineEnd)

  let mode = mode()
  if mode is# "\<C-v>"
    let mode = 'v'
    if lineStart < lineEnd
      echoerr 'block-wise selection unsupported, assuming character-wise selection'
    endif
  endif
  if mode is# 'v'
    " Swap column numbers if selection starts at cursor
    let [colStart, colEnd] = (colSelection <= colCursor) ? [colSelection, colCursor] : [colCursor, colSelection]
    let lines[-1] = lines[-1][:colEnd - (&selection is# 'inclusive' ? 1 : 2)]
    let lines[0]  = lines[0][colStart - 1:]
  endif
  " if mode is# 'V'

  if &l:fileformat is# 'dos'
    let ending = "\<CR>\<NL>"
  elseif &l:fileformat is# 'mac'
    let ending = "\<CR>"
  else " if is# 'unix'
    let ending = "\<NL>"
  endif

  return join(lines, ending)
endfunction

function! SearchVisualSelection() abort
  let l:result = GetVisualSelection()
  call SearchForAg(l:result)
endfunction

function! GtagsGoToDefine(string) abort
  let l:tmp_gtags_single_status = g:Gtags_Close_When_Single
  let l:tmp_gtags_auto_jump_status = g:Gtags_No_Auto_Jump
  let g:Gtags_Close_When_Single = 1
  let g:Gtags_No_Auto_Jump = 0
  execute 'Gtags -d '.expand("<cword>")
  let g:Gtags_Close_When_Single = l:tmp_gtags_single_status
  let g:Gtags_No_Auto_Jump = l:tmp_gtags_auto_jump_status
endfunction

