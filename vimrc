set encoding=utf-8
set fileencodings=utf-8,ucs-bom,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set fileencoding=utf-8

" line number
set number

" enable cursorline
set cursorline

" for ☆
set ambiwidth=double

" for vim-airline
let laststatus = 2
let g:airline_powerline_fonts = 1

" for syntastic
let g:syntastic_error_symbol = '✗'
let g:syntastic_style_error_symbol = '✠'
let g:syntastic_warning_symbol = '∆'
let g:syntastic_style_warning_symbol = '≈'


"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.vim/dein')
  call dein#begin('~/.vim/dein')

  " Let dein manage dein
  " Required:
  call dein#add('~/.vim/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('altercation/vim-colors-solarized')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('scrooloose/nerdtree')
  call dein#add('scrooloose/syntastic')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('kien/ctrlp.vim')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable


" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif


if has('gui_running')
  "set background=light
  set background=dark
else
  set background=dark
endif

colorscheme solarized

if has('gui_running')
"  set guioptions-=m  "remove menu bar  
"  set guioptions-=T  "remove toolbar  
"  set guioptions-=r  "remove right-hand scroll bar  
"  set guioptions-=L  "remove left-hand scroll bar
endif

" How can I open a NERDTree automatically when vim starts up if no files were specified?
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" How can I open NERDTree automatically when vim starts up on opening a directory?
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" How can I map a specific key or shortcut to open NERDTree?
map <C-n> :NERDTreeToggle<CR>

" set SignColumn color
hi SignColumn guibg=#0D3C48

" set custom color for Syntastic
hi SyntasticErrorSign guifg=Red guibg=#0D3C48
hi SyntasticWarningSign guifg=Yellow guibg=#0D3C48
hi SyntasticStyleErrorSign guifg=Red guibg=#0D3C48
hi SyntasticStyleWarningSign guifg=Yellow guibg=#0D3C48









if has('gui_running')
  set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h12:cANSI
endif

"End dein Scripts-------------------------
