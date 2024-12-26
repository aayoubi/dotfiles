
call plug#begin()
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'fatih/vim-go'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
call plug#end()

set nocompatible

set tabstop=4
set expandtab
set shiftwidth=4
set softtabstop=4

syntax on

nmap xv :!xmllint --noout %<CR>
nmap <C-n> :bnext<CR>
nmap <C-p> :bprev<CR>
nmap \q :nohlsearch<CR>
imap jk <Esc>
imap jj <Esc>

set incsearch
set ignorecase
set hlsearch

set foldlevel=99
set history=50
set undolevels=100
set scrolloff=2
set backspace=2
set ruler
set nofoldenable

filetype plugin indent on
set t_Co=256
set t_ut=
" colorscheme codedark
" colorscheme solarized
colorscheme catppuccin_mocha
