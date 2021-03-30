call plug#begin('~/.config/nvim/plugged')

" Colorscheme
Plug 'franbach/miramare'
Plug 'sheerun/vim-polyglot'
Plug 'frazrepo/vim-rainbow'

" Language plug-ins
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'neoclide/jsonc.vim'
Plug 'rust-lang/rust.vim'
Plug 'mattn/emmet-vim'
Plug 'scrooloose/syntastic'

" Files tree
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" Plug 'kyazdani42/nvim-web-devicons' for file icons

Plug 'lambdalisue/nerdfont.vim'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'vimsence/vimsence'
Plug 'vim-airline/vim-airline'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'
Plug 'lambdalisue/suda.vim'

call plug#end()
