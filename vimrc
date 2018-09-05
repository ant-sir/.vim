" vim: fdm=marker ts=2 sts=2 sw=2 fdl=0

set encoding=utf-8
set fileencodings=utf-8,ucs-bom,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set fileencoding=utf-8

set number
set smarttab cindent
let &tabstop=4
let &softtabstop=4
let &shiftwidth=4
set hlsearch ignorecase smartcase incsearch showmatch
set list
set listchars=tab:│\ ,trail:•,extends:❯,precedes:❮
set shiftround
set linebreak
let &showbreak='↪ '

"set autoread
set backspace=indent,eol,start

if !has('gui_running')
  set t_Co=256
endif


" enable cursorline
set cursorline

" for ☆
" set ambiwidth=double

" for vim-airline
let laststatus = 2
let g:airline_powerline_fonts = 1

" for syntastic
let g:syntastic_error_symbol = '✗'
let g:syntastic_style_error_symbol = '✠'
let g:syntastic_warning_symbol = '∆'
let g:syntastic_style_warning_symbol = '≈'


call plug#begin('~/.vim/plugged')

Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/syntastic'
Plug 'airblade/vim-gitgutter'
Plug 'kien/ctrlp.vim'
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
Plug 'valloric/youcompleteme'

call plug#end()


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
endif

"sync with OS clipboard
if exists('$TMUX')
    set clipboard=
  else
    set clipboard=unnamed
  endif


" How can I open a NERDTree automatically when vim starts up if no files were specified?
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" How can I open NERDTree automatically when vim starts up on opening a directory?
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" How can I map a specific key or shortcut to open NERDTree?
map <F7> :NERDTreeToggle<CR>

" map <F8> for Tagbar
nmap <F8> :TagbarToggle<CR>

" set SignColumn color
hi SignColumn guibg=#073642

" set custom color for Syntastic
hi SyntasticErrorSign guifg=Red guibg=#073642
hi SyntasticWarningSign guifg=Yellow guibg=#073642
hi SyntasticStyleErrorSign guifg=Red guibg=#073642
hi SyntasticStyleWarningSign guifg=Yellow guibg=#073642


" map for change from windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

inoremap <C-h> <left>
inoremap <C-k> <up>
inoremap <C-j> <down>
inoremap <C-l> <right>

" find current word in quickfix
nnoremap <C-f>w :execute "vimgrep ".expand("<cword>")." %"<cr>:copen<cr>
" find last search in quickfix
nnoremap <C-f>l :execute 'vimgrep /'.@/.'/g %'<cr>:copen<cr>

nmap <C-f>$ :call StripTrailingWhitespace()<CR>

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

" go back to previous position of cursor if any
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \  exe 'normal! g`"zvzz' |
  \ endif

if has('gui_running')
  set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h12:cANSI
endif


