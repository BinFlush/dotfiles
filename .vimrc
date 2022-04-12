set nocompatible
set number
set relativenumber
"set clipboard=unnamedplus
"set title
"set statusline+=%F " shows filename with path in bottom.
set laststatus=2
call plug#begin()

Plug 'https://github.com/lervag/vimtex'
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'
hi clear Conceal

Plug 'https://github.com/SirVer/ultisnips'
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

call plug#end()
set shiftwidth=4
set expandtab
set tabstop=4
"set mouse=a

:nnoremap <silent><esc> :noh<CR>
:nnoremap <esc>[ <esc>[
"nnoremap <esc> :noh<return><esc>
set is hls
"fix annoying spellcheck colors
hi clear SpellBad
hi SpellBad cterm=underline
" Set style for gVim
" hi SpellBad gui=undercurl
