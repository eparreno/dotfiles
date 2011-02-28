"" Use Vim settings, rather then Vi settings (much better!).
"" This must be first, because it changes other options as a side effect.
set nocompatible

"" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50  " keep 50 lines of command line history
set ruler       " show the cursor position all the time
set showcmd     " display incomplete commands
set incsearch   " do incremental searching
set number      " show line numbers
set nobk        " Don't create backup files
set noswapfile
set laststatus=2 " Always display the status line
set ffs=unix,dos,mac                  " support these files
" Don't use Ex mode, use Q for formatting
map Q gq

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  "" set filetype check on
  :filetype plugin indent on
  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
else
  set autoindent " always set autoindenting on
endif 

"" Style
:syntax on 
set t_Co=256                   " 256 colors
set background=dark
set guifont=Monaco:h13       " font family and font size
:colorscheme ir_black " color scheme

" hide toolbar
set guioptions=aAce
set guioptions-=T

"" enable spell check
" set spell

"" enable mouse
"set mouse=a

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
set sessionoptions+=unix,slash


" Set encoding
set encoding=utf-8
set fileencoding=utf-8

set autowrite      " auto saves changes when quitting and swiching buffer

" Whitespace stuff
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab     " make blank spaces from tabs
set ai                                  " automatically set the indent of a new line

" Numbers
set number
set numberwidth=5

""setting about indent
set autoindent
set smartindent

"automatically read the file again when it is changed outside of Vim
set autoread

" Tab completion options
set wildmode=list:longest,list:full
set complete=.,w,t
" ignore files
set wildignore+=*.log,.git,tmp/**,log/**


"" Mappings
" <leader>
let mapleader = ","

" Maps autocomplete to tab
"imap <Tab> <C-P>

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
nmap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
nmap <Leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>
" command-t
nmap <silent> <Leader>t :CommandT<CR>

" NERDTree
nmap <silent> <Leader>n :NERDTreeToggle %:p:h<CR>

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru} set ft=ruby

" Command-T configuration
let g:CommandTMaxHeight=20

"" Rails configuration
autocmd User Rails Rnavcommand step features/step_definitions -glob=**/* -suffix=_steps.rb
autocmd User Rails Rnavcommand config config -glob=**/* -suffix=.rb -default=routes
autocmd User Rails map <Leader>p :Rstep 
autocmd User Rails map <Leader>sp :RSstep 
autocmd User Rails map <Leader>tp :RTstep 
autocmd User Rails map <Leader>m :Rmodel 
autocmd User Rails map <Leader>c :Rcontroller 
autocmd User Rails map <Leader>v :Rview 
autocmd User Rails map <Leader>u :Runittest 
autocmd User Rails map <Leader>f :Rfunctionaltest 
autocmd User Rails map <Leader>i :Rintegrationtest 
autocmd User Rails map <Leader>h :Rhelper 
autocmd User Rails map <Leader>tm :RTmodel 
autocmd User Rails map <Leader>tc :RTcontroller 
autocmd User Rails map <Leader>tv :RTview 
autocmd User Rails map <Leader>tu :RTunittest 
autocmd User Rails map <Leader>tf :RTfunctionaltest 
autocmd User Rails map <Leader>ti :RTintegrationtest 
autocmd User Rails map <Leader>sm :RSmodel 
autocmd User Rails map <Leader>sc :RScontroller 
autocmd User Rails map <Leader>sv :RSview 
autocmd User Rails map <Leader>su :RSunittest 
autocmd User Rails map <Leader>sf :RSfunctionaltest 
autocmd User Rails map <Leader>si :RSintegrationtest 
autocmd User Rails map <Leader>g :Rconfig 
autocmd User Rails map <Leader>sg :RSconfig 
autocmd User Rails map <Leader>tg :RTconfig 

