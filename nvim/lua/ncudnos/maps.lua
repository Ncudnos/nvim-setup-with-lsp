vim.cmd[[
nnoremap <C-s> :w<Enter>
nnoremap <C-a> ggVG
vnoremap <C-c> :'<.'>%y+<Enter>
nnoremap <C-q> :bdelete!<Enter>
nnoremap <C-w> :q!<Enter>
nnoremap <C-z> :u<Enter>
nnoremap <C-d> :%d<Enter>
nnoremap <C-n> :Telescope file_browser<Enter>
nnoremap <C-l> :CocDiagnostics<Enter>
nnoremap <C-t> :ToggleTerm direction=float<Enter>
nnoremap <silent> \\ :CocDiagnostics<Enter>:q<Enter>
nnoremap <C-b> :bnext<Enter>
nnoremap <C-y> :noh<Enter>
nnoremap <C-f> ggVG==<Enter>
nnoremap <silent> vim :e $MYVIMRC<TAB><cr>

command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <C-x><C-z> coc#pum#visible() ? coc#pum#stop() : "\<C-x>\<C-z>"
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()

hi CocMenuSel guibg=#24285b guifg=#e0ffff

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>qf  <Plug>(coc-fix-current)
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
    else
        call feedkeys('K', 'in')
    endif
endfunction

" Find files using Telescope command-line sugar.
nnoremap <silent>;f <cmd>Telescope find_files<cr>
nnoremap <silent>;g <cmd>Telescope live_grep<cr>
nnoremap <silent>;h <cmd>Telescope help_tags<cr>
nnoremap <silent>;e <cmd>CocDiagnostics<cr>
nnoremap <silent>sf <cmd>Telescope file_browser<cr>

]]
