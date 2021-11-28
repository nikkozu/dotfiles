call plug#begin('~/.config/nvim/plugged')

" Language
Plug 'sheerun/vim-polyglot'
Plug 'mattn/emmet-vim'
Plug 'spf13/snipmate-snippets'
Plug 'shawncplus/phpcomplete.vim'
Plug 'scrooloose/syntastic'

" Colorscheme
Plug 'ghifarit53/tokyonight-vim'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Intellisense Engine
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Discord Presence
Plug 'vimsence/vimsence'

" Editor
Plug 'lambdalisue/suda.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Nerd
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree' |
    \ Plug 'Xuyuanp/nerdtree-git-plugin' |
    \ Plug 'ryanoasis/vim-devicons' |
    \ Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

call plug#end()
