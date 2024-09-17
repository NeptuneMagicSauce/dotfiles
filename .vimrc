syntax on
colorscheme koehler
" next line enables line wrap in vimdiff
au VimEnter * if &diff | execute 'windo set wrap' | endif
set diffopt+=iwhite
set diffopt+=iwhiteall

"enable syntax color
:syntax enable

"Show line number on the left side
:set number

" highlight the delimiter which matches the one under the cursor
set showmatch

"Command to display constantly the current filename
set laststatus=2
