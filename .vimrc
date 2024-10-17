" syntax highlighting
syntax on

" color scheme
colorscheme koehler

" enable line wrap in vimdiff
au VimEnter * if &diff | execute 'windo set wrap' | endif

" choose a better coloscheme for vimdiff
" TODO only change colors of diff highlights
" see https://stackoverflow.com/questions/2019281/load-different-colorscheme-when-using-vimdiff
"au VimEnter * if &diff | execute 'colorscheme industry' | endif
" better colors for vimdiff with termguicolor
au VimEnter * if &diff | execute 'set termguicolors' | endif

" diff ignores whitespace
set diffopt+=iwhite
set diffopt+=iwhiteall

" enable syntax color
syntax enable

" Show line number on the left side
set number

" highlight the delimiter which matches the one under the cursor
set showmatch

" Command to display constantly the current filename
set laststatus=2

" search case insensitive
set ignorecase

" incremental search: start finding with partial query
set incsearch

" automatic indentation
set autoindent

" smart case = search is case sensitive if query has upper case
"set smartcase
