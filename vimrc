" vim: fdm=marker ts=2 sts=2 sw=2 fdl=0

" ##########################文件编码设置##########################
" 编码
" encoding:vim内部使用的编码
" termencoding终端使用的编码(一般与encoding相同)
" fileencoding:当前文件编码(不在此处设置,vim会自动设置)
" fileencodings:可选的文件编码
"     utf-8不能放到usc-bom之前,latin1应为最后,default是encoding的值
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1


" ##########################常用基本设置##########################
" 行号
set number

set smarttab cindent

" tab宽度
let &tabstop=4
let &softtabstop=4
let &shiftwidth=4

" 搜索
set hlsearch ignorecase smartcase incsearch

" 开启list模式
" 在list模式可以显式显示tab，行尾结束符，空格等
" 使用listchars自定义显示格式
set list
set listchars=tab:│\ ,trail:•,extends:❯,precedes:❮

" 启用缩进
" 在insert模式，使用CTRL-T/CTRL-D可以增加/减少缩进
set shiftround

" 启用折行
" 用 ’nowrap’ 选项的一个弊端是你看不见你正在处理的整个句子。
" 当 ’wrap’ 选项开启时,会从单词中间断开,从而难以阅读。
" 一个好的解决方法是设置 ’linebreak’ 选项。
" 这样,Vim 将会在一个适当的地方回绕行显示,同时仍保持文件中的文本不变。
set linebreak
let &showbreak='↪ '
" 折行时保持缩进，VIM 8.0新特性
if v:version > 800
  set breakindent
endif

" 输入括号时，高亮匹配的括号
" set showmatch
" set matchtime=1

" 在状态行显示命令
set showcmd

" 确认对话框
" 多用于退出时文件已修改但未保存时询问,询问选项有:
" 保存,不保存,取消
" confirm
set cf

" 不使用折叠
set nofoldenable

" 不执行命令时不重画窗口，可以增加性能
" set lazyredraw

" 光标上下最少保留行数
" 比如当向下移动光标时,光标不会移动到当前编辑区最低部
" 才开始滚动编辑区,这样能保证看到部分连续的上下文
set scrolloff=7

" 同上,但对横向滚动起作用,且只有设置了nowrap(下面)的时候才起作用
" set sidescrolloff=7
" set sidescroll=1

" 滚动时，如果只剩最后一行，就一并显示
set display+=lastline

" use pipe
set noshelltemp

" 自动重新读入
" 如果vim发现文件在其他地方被修改了,自动重新读入
set autoread

set backspace=indent,eol,start

set t_Co=256

" 在状态栏显示补全项
set wildmenu
set wildignore+=*.o,*~,*.pyc

" for win
if has('win32') || has('win64')
  " windows默认加载用户目录下的vimfiles目录，为了使用用户目录下的.vim目录需添加到runtimepath中
  set runtimepath+=~/.vim

  " CTRL-P插件使用wildignore中的内容忽略一些文件
  set wildignore+=*\\.git\\*,*\\.hg\\*,*\\.svn\\*,*\\*.si4project\\*
else
  set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/*.si4project/*
endif

" 总在 Vim 窗口的右下角显示当前光标位置
set ruler

if has('gui_running')
  " gui选项
  " guioptions
  " m 菜单栏
  " g 灰色菜单项
  " t 可撕下的菜单
  " T 工具栏
  " r 右边滚动条总是存在
  " R 右边滚动条有垂直分割的窗口时总是存在
  " l 左边滚动条总是存在
  " L 左边滚动条有垂直分割的窗口时总是存在
  " b 底部的水平滚动条,大小为当前文件中的最长行
  " h 限制水平滚动条的长度为当前光标所在行,可减少计算量
  " 每个选项都可以使用加号"+"和减号"-"来开关
  set guioptions-=m  "remove menu bar
  set guioptions-=T  "remove toolbar
  set guioptions-=r  "remove right-hand scroll bar
  set guioptions-=L  "remove left-hand scroll bar
  " 设置字体
  set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h12:cANSI
endif

" 如果使用TMUX
if exists('$TMUX')
    set clipboard=
  else
    set clipboard=unnamed
endif

" 高亮显示光标所在行
set cursorline

" for ☆
" set ambiwidth=double


" ##########################按键映射设置##########################
" map:全局的映射,映射之后的按键可以递归(被再次映射)
" noremap:全局的映射,但映射后的按键不可递归(多用于定义一个命令)
" unmap:删除一个映射
" mapclear:删除所有映射
" 映射也区分模式,如果上述命令前有如下字符,则该命令只对该模式生效:
" n:normal(正常)模式下
" v:可视模式
" i:插入模式
" c:命令行模式

let mapleader = ","
let g:mapleader = ","

function! QuickFixToggle() abort
  if len(filter(range(1, winnr('$')), 'getwinvar(v:val, "&ft") == "qf"')) == 0
    exec 'copen'
  else
    exec 'cclose'
  endif
endfunction

nmap <F2> :call QuickFixToggle()<CR>

" 结合CTRL键在窗口间切换
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" insert模式下结合CTRL键移动光标
inoremap <C-h> <left>
inoremap <C-k> <up>
inoremap <C-j> <down>
inoremap <C-l> <right>

" 使用<leader><ENTRY>取消搜索产生的高亮
nmap <leader><leader><cr> :noh<cr>

" 查找当前光标所在的word
nnoremap <leader><leader>w :execute "vimgrep! ".expand("<cword>")." %"<cr>:copen<cr>
" 重新查找上一次搜索过的字符
nnoremap <leader><leader>l :execute 'vimgrep! /'.@/.'/g %'<cr>:copen<cr>

" 清除行尾无效的空白
nmap <leader><leader>$ :execute '%s/\s\+$//g'<CR>


"###########################安装/加载插件##########################
" 使用vim-plug插件管理器
" vim-plug的简要使用方法:
" 命令:
" :PlugInstall  安装列表中的插件
" :PlugUpdate   安装/升级列表中的插件
" :PlugUpgrade 	更新vim-plug这个插件管理器
" :PlugStatus 	查看插件状态
" :PlugClean    删除一些未使用的插件,删除前会询问
" 安装或加载插件时的一些选项:
" do 	  当安装/更新插件后的回调命令:系统命令或定义的一个方法
"   例:Plug '插件', { 'do': './install.py' }
"   例:Plug '插件', { 'do': function('自定义方法名') }
" on 	  当在vim中执行某个命令时才加载这个插件
"   例:Plug '插件', { 'on': '命令' }
"   例:Plug '插件', { 'on': ['命令1', '命令2'] }
" for 	  当打开某个类型的文件时才加载这个插件
"   例:Plug '插件', { 'for': '文件类型' }
"   例:Plug '插件', { 'for': ['文件类型1','文件类型2'] }
" 也可以同时使用上述另个选项:
"   例:Plug '插件',  { 'on': '命令', 'for': '文件类型' }

" 开始插件加载,括号中的是插件的安装和加载目录
" 每个插件下面的是对这个插件的设置
call plug#begin('~/.vim/plugged')

" ########
Plug 'altercation/vim-colors-solarized'

" ########
Plug 'tpope/vim-fugitive'

" ########
Plug 'vim-airline/vim-airline' "{{{
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#branch#enabled = 1
"}}}

" ########
Plug 'vim-airline/vim-airline-themes'

" ########
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeCWD', 'NERDTree'] } "{{{
  let g:NERDTreeDirArrowExpandable = '▸'
  let g:NERDTreeDirArrowCollapsible = '▾'
  map <F8> :NERDTreeToggle<CR>
  map <C-F8> :NERDTreeCWD<CR>
  " How can I open NERDTree automatically when vim starts up on opening a directory?
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter *
    \ if argc() == 1 &&
      \ isdirectory(argv()[0]) &&
      \ !exists("s:std_in") |
      \ exe 'NERDTree' argv()[0] |
      \ wincmd p |
      \ ene |
    \ endif
"}}}

" ########
Plug 'w0rp/ale'

" ########
Plug 'airblade/vim-gitgutter'

" ########
Plug 'kien/ctrlp.vim' "{{{
  let g:ctrlp_clear_cache_on_exit = 0
  let g:ctrlp_max_files = 0
"}}}

" ########
Plug 'majutsushi/tagbar', { 'on': ['TagbarToggle', 'TagbarOpen'] } "{{{
  let g:tagbarflag = 0
  function! TagbarToggleFunc() abort
    if g:tagbarflag == 0
      execute 'TagbarOpen fj'
      let g:tagbarflag = 1
    else
      let g:tagbarflag = 0
      execute 'TagbarToggle'
    endif
  endfunction
  nnoremap <silent> <F9> :call TagbarToggleFunc()<CR>
"}}}

" ########
Plug 'valloric/youcompleteme' "{{{
  let g:ycm_global_ycm_extra_conf = "~/.vim/plugged/youcompleteme/third_party/ycmd/examples/.ycm_extra_conf.py"
  let g:ycm_collect_identifiers_from_tag_files = 1
  " 默认需要ctrl-sapce才能触发语义补全
  " let g:ycm_semantic_triggers =  {
  "   \ 'c,cpp': ['re!\w{2}'],
  "   \ }
"}}}

" ########
Plug 'scrooloose/nerdcommenter'

" ########
if executable('ag')
  Plug 'rking/ag.vim', {'on': ['Ag']} "{{{
    let g:ag_prg="ag --vimgrep --smart-case"
    let g:ag_highlight=1

    cnoreabbrev ag Ag

    nmap <leader><leader>s :execute "Ag ".expand("<cword>")<CR>

    function! GetVisualSelection() abort
      " Why is this not a built-in Vim script function?!
      let [line_start, column_start] = getpos("'<")[1:2]
      let [line_end, column_end] = getpos("'>")[1:2]
      let lines = getline(line_start, line_end)
      if len(lines) == 0
        return ''
      endif
      let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
      let lines[0] = lines[0][column_start - 1:]

      return join(lines, "\n")
    endfunction

    function! SearchVIsualSelection() abort
      let l:result = GetVisualSelection()
      execute 'Ag "'.l:result.'"'
    endfunction

    vnoremap <leader><leader>v :call SearchVIsualSelection()<CR>
  "}}}
endif

" ########
Plug 'terryma/vim-multiple-cursors'

" ########
if executable('gtags')
  let g:Gtags_No_Auto_Jump = 1
  function! GtagsGoToDefine(string) abort
    let l:tmp_gtags_single_status = g:Gtags_Close_When_Single
    let l:tmp_gtags_auto_jump_status = g:Gtags_No_Auto_Jump
    let g:Gtags_Close_When_Single = 1
    let g:Gtags_No_Auto_Jump = 0
    execute 'Gtags -d '.expand(a:string)
    let g:Gtags_Close_When_Single = l:tmp_gtags_single_status
    let g:Gtags_No_Auto_Jump = l:tmp_gtags_auto_jump_status
  endfunction
  nmap <leader><leader>f :GtagsCursor<CR>
  nmap <leader><leader>d :call GtagsGoToDefine("<cword>")<CR>
  nmap <leader><leader>r :execute 'Gtags -r '.expand("<cword>")<CR>
  nmap <F12> :GtagsUpdate<CR>
endif

" ########
Plug 'vim-scripts/Mark--Karkat'

call plug#end()


" ##########################背景主题设置##########################
" 似乎必须放在插件的后面

set background=dark
colorscheme solarized


" ##########################hook函数调用##########################
" 当最后一个buffer关闭时，就退出所有窗口
autocmd BufEnter *
  \ if 0 == len(filter(range(1, winnr('$')), 'empty(getbufvar(winbufnr(v:val), "&bt"))')) |
    \ qa! |
  \ endif

" 让光标回到上次离开时的位置
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \ exe 'normal! g`"zvzz' |
  \ endif


