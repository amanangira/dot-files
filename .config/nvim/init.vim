set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.

set shiftwidth=4    " Indents will have a width of 4
set softtabstop=4   " Sets the number of columns for a TAB
set expandtab       " Expand TABs to spaces
set ic
set directory=$HOME/.vim/swapfiles//
set autoindent
set number " enable line numbers
set runtimepath^=~/.vim runtimepath+=~/.vim/after " load vim config to nvim
set wrap 

call plug#begin("~/.vim/plugged")
	Plug 'dracula/vim'
	Plug 'relastle/bluewery.vim'
	Plug 'vim-airline/vim-airline' " command mode status bar 
	Plug 'scrooloose/nerdtree'
	" If installed using Homebrew
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets' 
    Plug 'tpope/vim-fugitive'
    Plug 'ludovicchabant/vim-gutentags'
    Plug 'arnaud-lb/vim-php-namespace'
call plug#end()

if (has("termguicolors"))
	set termguicolors
endif

syntax enable
colorscheme dracula
let mapleader = " "
let &packpath=&runtimepath
source ~/.vimrc

" nerdtree
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
autocmd StdinReadPre * let s:std_in=1
" toggle nerdtree
map <C-n> :NERDTreeToggle<CR>

" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" FZF file search
nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent> <Leader>f :Rg<CR>

" Change split pane height/width 
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>

" Toggle window tabs right and left respectively 
nnoremap <C-h> gT <CR>
nnoremap <C-l> gt <CR>

" ultiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

let g:gutentags_cache_dir="/Users/amanangira/.vim/tags"
nmap <silent> <leader>m :History<CR>


" vim-php-namespaces
function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction
autocmd FileType php inoremap \u <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>
