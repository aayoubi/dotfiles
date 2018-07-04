set nocompatible
colorscheme wombat256mod
filetype off

nmap xv :!xmllint --noout %<CR>
nmap <C-n> :bnext<CR>
nmap <C-p> :bprev<CR>
nmap \q :nohlsearch<CR>
set incsearch
set ignorecase
set smartcase
set hlsearch
syntax on

set foldlevel=99
set history=50
set undolevels=100
set softtabstop=4
set shiftwidth=4
set scrolloff=2
set foldmethod=syntax

set backspace=2
set ruler
set tabstop=4 expandtab
set list listchars=trail:-

let g:airline#extensions#tabline#enabled = 1

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-surround'
Plugin 'kien/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'altercation/vim-colors-solarized'
Plugin 'wombat256.vim'
Plugin 'klen/python-mode'
Plugin 'davidhalter/jedi-vim'
call vundle#end()
filetype plugin indent on

