" Remember cursor position
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

inoremap jk <ESC>
let mapleader = " "
filetype plugin indent on
syntax on
set encoding=utf-8
set clipboard=unnamedplus
set hls is
let g:python3_host_prog = '/usr/bin/python3'
