if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif

set nocompatible	" Use Vim defaults (much better!)
set bs=indent,eol,start		" allow backspacing over everything in insert mode
"set ai			" always set autoindenting on
"set backup		" keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time

" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup redhat
  autocmd!
  " In text files, always limit the width of text to 78 characters
  " autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
  " don't write swapfile on most commonly used directories for NFS mounts or USB sticks
  autocmd BufNewFile,BufReadPre /media/*,/run/media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
  " start with spec file template
  autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
  augroup END
endif

if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add $PWD/cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

filetype plugin on

if &term=="xterm"
     set t_Co=8
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif

" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"

set nocompatible " 关闭 vi 兼容模式
syntax on " 自动语法高亮
set number " 显示行号
set cursorline " 突出显示当前行
set ruler " 打开状态栏标尺
set shiftwidth=4 " 设定 << 和 >> 命令移动时的宽度为 4
set softtabstop=4 " 使得按退格键时可以一次删掉 4 个空格
set tabstop=4 " 设定 tab 长度为 4
set nobackup " 覆盖文件时不备份
filetype plugin indent on " 开启插件
set backupcopy=yes " 设置备份时的行为为覆盖
set ignorecase smartcase " 搜索时忽略大小写，但在有一个或以上大写字母时仍保持对大小写敏感
set nowrapscan " 禁止在搜索到文件两端时重新搜索
set incsearch " 输入搜索内容时就显示搜索结果
set hlsearch " 搜索时高亮显示被找到的文本
set noerrorbells " 关闭错误信息响铃
set novisualbell " 关闭使用可视响铃代替呼叫
set t_vb= " 置空错误铃声的终端代码
set magic " 设置魔术
set hidden " 允许在有未保存的修改时切换缓冲区，此时的修改由 vim 负责保存
set guioptions-=T " 隐藏工具栏
set guioptions-=m " 隐藏菜单栏
set smartindent " 开启新行时使用智能自动缩进
set backspace=indent,eol,start " 不设定在插入状态无法用退格键和 Delete 键删除回车符
"set mouse=a
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1
set termencoding=utf-8
set fileformats=unix
set encoding=prc
set foldenable      " 允许折叠  
set foldmethod=manual  " 手动折叠  
set nocompatible  "去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限
set pastetoggle=<F9>
 " 显示中文帮助
 if version >= 603
	set helplang=cn
	set encoding=utf-8
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cscope
" :cs find s ---- 查找C语言符号，即查找函数名、宏、枚举值等出现的地方  
" :cs find g ---- 查找函数、宏、枚举等定义的位置，类似ctags所提供的功能  
" :cs find d ---- 查找本函数调用的函数  
" :cs find c ---- 查找调用本函数的函数  
" :cs find t ---- 查找指定的字符串  
" :cs find e ---- 查找egrep模式，相当于egrep功能，但查找速度快多了  
" :cs find f ---- 查找并打开文件，类似vim的find功能  
" :cs find i ---- 查找包含本文件的文件
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>  
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>  
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>  
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR> 
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR> 
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR> 
nmap <C-\>f :cs find f <C-R>=expand("<cword>")<CR><CR> 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" win-manager
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:winManagerWindowLayout = "TagList|FileExplorer,BufExplorer"
let g:NERDTree_title='NERD Tree'
 function! NERDTree_Start()
     exec 'NERDTree'
 endfunction

 function! NERDTree_IsValid()
     return 1
 endfunction

 " 绑定F2到winmanager
 nmap <silent> <F2> :WMToggle<CR>
 nmap wm :WMToggle&lt;cr&gt;:set buftype=&lt;cr&gt;             

"-----------------------------------------------------------------
" plugin - taglist.vim 查看函数列表，需要ctags程序
" F4 打开隐藏taglist窗口
"-----------------------------------------------------------------
nnoremap <silent><F4> :TlistToggle<CR>
let Tlist_Show_One_File = 1 " 不同时显示多个文件的tag，只显示当前文件的
let Tlist_Exit_OnlyWindow = 1 " 如果taglist窗口是最后一个窗口，则退出vim
let Tlist_Auto_Open = 0
let Tlist_Auto_Update = 1
let Tlist_Hightlight_Tag_On_BufEnter = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_Process_File_Always = 1
let Tlist_Display_Prototype = 0
let Tlist_Compact_Format = 1
autocmd VimEnter * wincmd p

"-----------------------------------------------------------------
" plugin - NERD_tree.vim 以树状方式浏览系统中的文件和目录
" NERDtree 打开NERD_tree :NERDtreeClose 关闭NERD_tree
" o 打开关闭文件或者目录 t 在标签页中打开
" T 在后台标签页中打开 ! 执行此文件
" p 到上层目录 P 到根目录
" K 到第一个节点 J 到最后一个节点
" u 打开上层目录 m 显示文件系统菜单（添加、删除、移动操作）
" r 递归刷新当前目录 R 递归刷新当前根目录
"-----------------------------------------------------------------
 ""窗口位置
" let g:NERDTreeWinPos='left'
"""打开vim时自动打开NERDTree
"autocmd vimenter * NERDTree
""打开新的buffer时自动定位到编辑窗口
autocmd VimEnter * wincmd p
"修改树的显示图标
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
""窗口是否显示行号
let g:NERDTreeShowLineNumbers=1
""不显示隐藏文件
let g:NERDTreeHidden=0
""打开vim时如果没有文件自动打开NERDTree
"autocmd vimenter * if !argc()|NERDTree|endif
""退出时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd bufenter * if (winnr("$") == 2 && exists("b:NERDTree") &&b:NERDTreeType == "primary")  | qa | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" easy-align
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" air-line
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2  "永远显示状态栏
set t_Co=256      "在windows中用xshell连接打开vim可以显示色彩

"打开tabline功能,方便查看Buffer和切换,省去了minibufexpl插件
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
" 关闭状态显示空白符号计数
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#symbol = '!'
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
" old vim-powerline symbols
let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_symbols.branch = '⭠'
let g:airline_symbols.readonly = '⭤'
nnoremap <C-S-tab> :bprevious<CR> 
nnoremap <C-tab> :bnext<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"vim-auto-popup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"设定需要生效的文件类型，如果是 "*" 的话，代表所有类型
let g:apc_enable_ft = {'*':1, }

" 设定从字典文件以及当前打开的文件里收集补全单词，详情看 ':help cpt'
set cpt=.,k,w,b

" 不要自动选中第一个选项。
set completeopt=menu,menuone,noselect

" 禁止在下方显示一些啰嗦的提示
set shortmess+=c

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"vim-plug
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'vim-airline/vim-airline'
Plug 'vim-scripts/taglist.vim'
Plug 'vim-scripts/winmanager'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'skywind3000/vim-terminal-help'
Plug 'skywind3000/vim-auto-popmenu'
Plug 'skywind3000/vim-dict'
call plug#end()
