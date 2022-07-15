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

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'kien/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'altercation/vim-colors-solarized'
" Plugin 'klen/python-mode'
" Plugin 'davidhalter/jedi-vim'
Plugin 'fatih/vim-go'
Plugin 'tomasiser/vim-code-dark'
Plugin 'jlanzarotta/bufexplorer'
call vundle#end()

filetype plugin indent on
set t_Co=256
set t_ut=
colorscheme codedark
" colorscheme solarized
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'codedark'
