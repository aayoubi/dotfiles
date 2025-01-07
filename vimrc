
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

inoremap jj <Esc>
nnoremap <Space>p :CtrlP<CR>
nnoremap <leader>q :q!<cr>
nnoremap <leader>z :wq<cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>n :bnext<cr>
nnoremap <leader>N :bprev<cr> 

let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1

autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
