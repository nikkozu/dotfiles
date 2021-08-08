" list extended config files
let g:config_file_list = [
    \ 'coc.vim',
    \ 'plugins.vim'
  \ ]

" source the config_file_list
let g:nvim_config_root = expand('<sfile>:p:h')
for s:fname in g:config_file_list
    execute printf('source %s/%s', g:nvim_config_root, s:fname)
endfor


" === Editor ===
set et          " use space when <Tab> is inserted
set sts=4       " number of space for <Tab>
set sw=4        " number of space for auto indent
set ic          " ignore case in pattern
set scs         " no ignore case when pattern has uppercase
set mouse=a     " enable all mouse modes
set nu rnu      " print relative line number of each line
set so=5        " min. number of lines above and below cursor
set acd         " change dir to the file in current window
set hi=500      " total history lines
" set mps+=<:>    " match pairs character

" highlight cursorline (fix split window problem)
au VimEnter,WinEnter,BufWinEnter,FocusGained,CmdwinEnter * setlocal cursorline
au WinLeave,FocusLost,CmdwinLeave * setlocal nocursorline
" === Editor End ===


" === FileType ===
" disable auto comment on new line
au FileType * setlocal fo-=cro
" change indent to 2 for json file
au FileType json,jsonc setlocal et sts=2 sw=2
" comment on jsonc
au FileType json syntax match Comment +\/\/.\+$+
" === FileType End ===


" === Window ===
set spr         " open new window to right
set sb          " open new window to below
" === Window End ===


" === Colorscheme ===
set tgc         " Enable 24-bit RGB color

" colorscheme plugin configs
let g:tokyonight_style='night'
let g:tokyonight_enable_italic=1
let g:tokyonight_cursor='green'

colo tokyonight " set the colorsheme
" === Colorscheme End ===


" === Plugins ===
" airline
let g:airline_theme="tokyonight"
let g:airline#extensions#whitespace#enabled=0

" nerdcommenter
let g:NERDSpaceDelims=1
let g:NERDCompactSexyComs=1

" nerdtree
let g:NERDTreeWinPos="right"
let g:NERDTreeGitStatusUseNerdFonts=1

" vimsence
let g:vimsence_small_text="NyaaVim"
let g:vimsence_file_explorer_details="Looking for problems"
" === Plugins End ===


" === Custom Commands ===
" open neovim config files
command! -nargs=0 NvimCfg :e ~/.config/nvim/init.vim
" open neovim plugins files
command! -nargs=0 NvimCfgPlug :e ~/.config/nvim/plugins.vim

" coc custom commands
command! -nargs=0 Prettier :CocCommand prettier.formatFile
" === Custom Commands End ===


" === Custom Keybinds ===
" copies filepath to clipboard
:nnoremap <silent> yf :let @+=expand('%:p')<CR>
" copies pwd to clipboard
:nnoremap <silent> yd :let @+=expand('%:p:h')<CR>

" NERDTree
nnoremap <C-n>      :NERDTreeToggle<CR>
nnoremap <leader>r  :NERDTreeRefreshRoot<CR>
nnoremap <leader>n  :NERDTreeFind<CR>

" terminal
nnoremap <leader>t  :split term://zsh<CR>
" === Custom Keybinds End ===

