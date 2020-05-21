" System
" ----------------------------------------
set autoread
set path+=**
set shell=fish
let g:loaded_python_provider = 1  " Disable python2


" Style
" ----------------------------------------
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkred guibg=darkred
" autocmd ColorScheme * highlight BadTabs ctermbg=darkred guibg=darkred
colorscheme dracula
match ExtraWhitespace /\s\+\%#\@<!$/  " show trailing whitespace
" match BadTabs /[^\t]\zs\t\+/  " show tabs not at start of line

set number
set termguicolors
set colorcolumn=100
set nowrap


" Window handling
" ----------------------------------------
nnoremap <C-H> <C-W>h|xnoremap <C-H> <C-W>h|
nnoremap <C-J> <C-W>j|xnoremap <C-J> <C-W>j|
nnoremap <C-K> <C-W>k|xnoremap <C-K> <C-W>k|
nnoremap <C-L> <C-W>l|xnoremap <C-L> <C-W>l|
nnoremap + 10<C-W><
nnoremap - 10<C-W>>
nnoremap <C-W>+ 5<C-W>+
nnoremap <C-W>- 5<C-W>-

set splitright
set splitbelow


" Tab handling
" ----------------------------------------
set tabstop=4         " A tab is 4 spaces
set softtabstop=4     " Insert 4 spaces when tab is pressed
set shiftwidth=4      " An indent is 4 spaces
set expandtab         " Always uses spaces instead of tabs
"set shiftround        " Round indent to nearestshiftwidth multiple


" Search
" ----------------------------------------
"set ignorecase        " /\c to use once
"set incsearch
set nohlsearch


" Folding
" ----------------------------------------
set foldmethod=indent
set foldlevel=99
nnoremap <leader><leader> za


" Other Bindings
" ----------------------------------------
map <space> <leader>
nnoremap <delete> l
" Save and execute current file
nnoremap <F5> :w<CR>:!%:p<CR>
nnoremap <leader>~ cd %:h<CR>

" alternate files
nnoremap gn :e #<CR>


" Language specific
" ----------------------------------------
autocmd filetype python setlocal ts=4 sts=4 sw=4
autocmd filetype python nnoremap <F4> :w<CR>:!python %:p<CR>
autocmd filetype haskell setlocal ts=2 sts=2 sw=2
autocmd filetype haskell nnoremap <F4> :w<CR>:!runghc %:p<CR>
autocmd filetype scala nnoremap <F4> :w<CR>:!scala %:p<CR>
autocmd filetype javascript nnoremap <F4> :w<CR>:!node %:p<CR>
autocmd filetype nix setlocal ts=2 sts=2 sw=2
autocmd filetype elm setlocal ts=2 sts=2 sw=2
autocmd filetype c setlocal ts=4 sts=4 sw=4
autocmd filetype text setlocal wrap linebreak
autocmd Syntax hamlet syn match hmTrailHash /\(\s#$\)/
autocmd Syntax hamlet hi link hmTrailHash Comment

