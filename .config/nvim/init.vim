call plug#begin("~/.vim/plugged")
	Plug 'dracula/vim'
	Plug 'relastle/bluewery.vim'
call plug#end()

if (has("termguicolors"))
	set termguicolors
endif
syntax enable
colorscheme dracula

" load vim config to nvim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc
