call plug#begin()
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'fatih/vim-go'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
call plug#end()

set nocompatible

" ── Options ──────────────────────────────────────────────────────────────────

set number relativenumber
set mouse=a
set noshowmode
set breakindent
set undofile
set ignorecase smartcase
set signcolumn=yes
set updatetime=250
set timeoutlen=300
set splitright splitbelow
set list listchars=tab:»\ ,trail:·,nbsp:␣
set cursorline
set scrolloff=10
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
set autoindent
set wrap linebreak
set nofoldenable foldlevel=99
set incsearch hlsearch
set history=1000 undolevels=1000
set backspace=2

syntax on
filetype plugin indent on
set t_Co=256
set t_ut=
colorscheme catppuccin_mocha

" ── Leader ───────────────────────────────────────────────────────────────────

let mapleader = " "

" ── Keymaps ──────────────────────────────────────────────────────────────────

inoremap jj <Esc>
nnoremap <Esc> :nohlsearch<CR>

" File ops
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q!<CR>
nnoremap <leader>z :wq<CR>

" Buffers
nnoremap <leader>n :bnext<CR>
nnoremap <leader>N :bprev<CR>

" Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Clipboard (paste without clobbering register; yank to system clipboard)
xnoremap <leader>p "_dP
vnoremap <leader>y "+y
nnoremap <leader>Y "+Y

" File explorer (mirrors <leader>e / neotree)
nnoremap <leader>e :NERDTreeToggle<CR>

" Fuzzy find (mirrors Telescope bindings)
nnoremap <leader>sf :Files<CR>
nnoremap <leader>sg :Rg<CR>
nnoremap <leader>/  :BLines<CR>
nnoremap <leader><leader> :Buffers<CR>

" Disable arrow keys
nnoremap <left>  :echo "Use h to move!!"<CR>
nnoremap <right> :echo "Use l to move!!"<CR>
nnoremap <up>    :echo "Use k to move!!"<CR>
nnoremap <down>  :echo "Use j to move!!"<CR>

" XML validation
nmap xv :!xmllint --noout %<CR>

" ── Go ───────────────────────────────────────────────────────────────────────

let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1

autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>t <Plug>(go-test)
