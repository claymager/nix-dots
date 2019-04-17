" Style
" ----------------------------------------
let g:SimpylFold_docstring_preview = 1
let g:airline_theme                = 'dracula'


" Text expansion
" ----------------------------------------
let g:UltiSnipsEditSplit               = "vertical"
let g:UltiSnipsExpandTrigger           = "<tab>"
let g:UltiSnipsJumpBackwardTrigger     = "<s-tab>"
let g:UltiSnipsJumpForwardTrigger      = "<tab>"
let g:UltiSnipsSnippetsDir             = expand("$HOME/.config/nvim/snippets/")
let g:ultisnips_python_style = "numpy"
let g:deoplete#enable_at_startup = 1

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
        \ 'haskell': ['hie'],
        \ }
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> gh :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> gr :call LanguageClient_textDocument_references()<CR>
nnoremap <silent> gs :call LanguageClient_textDocument_documentSymbol()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
" nnoremap <silent> gf :call LanguageClient_textDocument_formatting()<CR>

