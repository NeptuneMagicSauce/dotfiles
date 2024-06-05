syntax on
colorscheme koehler
" next line enables line wrap in vimdiff
au VimEnter * if &diff | execute 'windo set wrap' | endif
set diffopt+=iwhite
set diffopt+=iwhiteall
