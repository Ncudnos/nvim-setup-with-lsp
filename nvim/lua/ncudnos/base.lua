vim.cmd[[
set number
set autochdir
set ruler
set cursorline
set guicursor=""
syntax on
filetype plugin indent on
set bs=2
set smartindent
set wildmenu
set relativenumber
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set encoding=UTF-8
set wrap
set mouse=a
set title
set nobackup
set nowb
set noswapfile
set splitbelow
set splitright
set laststatus=2
set background=dark

""ctags
command! MakeTags !ctags -R .
]]
