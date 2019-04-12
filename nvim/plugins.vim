" Style
" ----------------------------------------
let g:SimpylFold_docstring_preview = 1
let g:airline_theme                = 'dracula'


" Text expansion
" ----------------------------------------
let g:UltiSnipsEditSplit               = "vertical"
" let g:UltiSnipsExpandTrigger           = "<tab>"
" let g:UltiSnipsJumpBackwardTrigger     = "<s-tab>"
" let g:UltiSnipsJumpForwardTrigger      = "<tab>"
" let g:UltiSnipsSnippetsDir             = expand("$HOME/.config/nvim/snippets/")
" let g:ultisnips_python_style = "numpy"
autocmd BufEnter * call ncm2#enable_for_buffer()
set shortmess+=c
set completeopt=noinsert,menuone,noselect
au TextChangedI * call ncm2#auto_trigger()
" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
" inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Use <TAB> to select the popup menu:
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" wrap existing omnifunc
" Note that omnifunc does not run in background and may probably block the
" editor. If you don't want to be blocked by omnifunc too often, you could
" add 180ms delay before the omni wrapper:
"  'on_complete': ['ncm2#on_complete#delay', 180,
"               \ 'ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
au User Ncm2Plugin call ncm2#register_source({
        \ 'name' : 'css',
        \ 'priority': 9,
        \ 'subscope_enable': 1,
        \ 'scope': ['css','scss'],
        \ 'mark': 'css',
        \ 'word_pattern': '[\w\-]+',
        \ 'complete_pattern': ':\s*',
        \ 'on_complete': ['ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
        \ })

" Press enter key to trigger snippet expansion
" The parameters are the same as `:help feedkeys()`
inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')

" c-j c-k for moving in snippet
" let g:UltiSnipsExpandTrigger		= "<Plug>(ultisnips_expand)"
let g:UltiSnipsJumpForwardTrigger	= "<c-j>"
let g:UltiSnipsJumpBackwardTrigger	= "<c-k>"
let g:UltiSnipsRemoveSelectModeMappings = 0






" LaTeX
" ----------------------------------------
let g:tex_conceal               = ''
let g:tex_flaver                = 'latex'
let g:vimtex_compiler_progname  = 'nvr'
let g:vimtex_fold_manual        = 1
let g:vimtex_latexmk_continuous = 1


" Syntax
" ----------------------------------------
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list            = 1
let g:syntastic_check_on_open            = 1
let g:syntastic_check_on_wq              = 1


" Bindings
" ----------------------------------------
nnoremap <leader>t :Tab /=<CR>
nnoremap <leader>g :Tab /\s\ze\S/l0<CR>
nnoremap <leader>F :NERDTreeFind<CR>
nnoremap <leader>f :NERDTreeToggle<CR>

let g:LanguageClient_serverCommands = {
        \ 'python': ['pyls'],
        \ }
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> gh :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> gr :call LanguageClient_textDocument_references()<CR>
nnoremap <silent> gs :call LanguageClient_textDocument_documentSymbol()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
nnoremap <silent> gf :call LanguageClient_textDocument_formatting()<CR>

