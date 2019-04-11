" Of course
set nocompatible

syntax on
filetype plugin indent on

" Window handling
nnoremap <C-H> <C-W>h|xnoremap <C-H> <C-W>h|
nnoremap <C-J> <C-W>j|xnoremap <C-J> <C-W>j|
nnoremap <C-K> <C-W>k|xnoremap <C-K> <C-W>k|
nnoremap <C-L> <C-W>l|xnoremap <C-L> <C-W>l|
nnoremap + 10<C-W><
nnoremap - 10<C-W>>

nnoremap <F5> :w:!%:p
map <space> <leader>
nnoremap <leader>f :NERDTreeFind<CR>
nnoremap <leader>t :NERDTreeToggle<CR>

set termguicolors
colorscheme dracula
set path+=**
set autoread

set number            "Number lines
set title

set tabstop=2         "A tab is 2 spaces
set softtabstop=2     "Insert 2 spaces when tab is pressed
set shiftwidth=2      "An indent is 2 spaces

autocmd filetype python setlocal ts=4 sts=4 sw=4

set expandtab	        "Always uses spaces instead of tabs
"set shiftround        "Round indent to nearestshiftwidth multiple

set shell=fish
"set ignorecase
"set incsearch
set nohlsearch

set colorcolumn=100
set nowrap

set foldmethod=indent
set foldlevel=99
nnoremap <leader><leader> za

set splitright
set splitbelow

let g:airline_theme                      = 'dracula'
let g:loaded_python_provider             = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list            = 1
let g:syntastic_check_on_open            = 1
let g:syntastic_check_on_wq              = 1

nnoremap ZX ZQ
nnoremap <leader>t :Tab /=
nnoremap <leader>g :Tab /\s\ze\S/l0

let g:SimpylFold_docstring_preview=1

autocmd VimEnter * NERDTreeMirror
autocmd BufWinEnter * NERDTreeMirror

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion   = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
"let g:SuperTabDefaultCompletionType   = '<C-n>'
" help YCM find clang, among other things
let g:ycm_global_ycm_extra_conf = '~/.config/nvim/ycm_extra_conf.py'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger       = "<tab>"
let g:UltiSnipsJumpForwardTrigger  = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsEditSplit           = "vertical"
let g:UltiSnipsSnippetsDir         = expand("$HOME/.config/nvim/snippets/")

let g:ultisnips_python_style = "numpy"

let g:tex_flaver = 'latex'
let g:tex_conceal = ''
let g:vimtex_fold_manual = 1
let g:vimtex_latexmk_continuous = 1
let g:vimtex_compiler_progname = 'nvr'
