" Use Vim settings, rather than Vi settings
set nocompatible

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Keep 50 lines of command line history
set history=50

" Always show the cursor position
set ruler

" Display incomplete commands
set showcmd

" Do incremental searching
set incsearch

" Turn on autoindenting
set autoindent

" Turn on hidden buffers
set hidden

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo, so that you can undo CTRL-U after inserting a line break
inoremap <C-U> <C-G>u<C-U>

" Switch syntax and search highlighting on, when the terminal has colors
if &t_Co > 2 || has('gui_running')
    syntax on
    set hlsearch
endif

" Only do this part when compiled with support for autocommands
if has('autocmd')
    " Enable file type detection
    filetype plugin indent on
    " When editing a file, always jump to the last known cursor position
    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \     exe "normal! g`\"" |
        \ endif
endif

" Convenient command to see the difference between the current buffer and the file it was loaded from
if !exists(':DiffOrig')
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
endif
if( &diff )
    colorscheme vividchalk
endif

" Set tab behavior
set tabstop=4
set expandtab
set shiftwidth=4

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=2;
highlight OutputStatements ctermbg=3;
highlight DiffText      ctermbg=DarkRed
highlight DiffText      cterm=bold ctermbg=52 gui=bold guibg=Red

" Highlight lines longer than 131 characters
"let w:em=matchadd('ErrorMsg', '\%>130v.\+')
match ErrorMsg '\%>130v.\+'
2match ExtraWhiteSpace '\s\+$'
"3match OutputStatements '/^\s*var_dump\|^\s*echo\|^\s*printf'


" Custom commands
command Fname execute 'g/private\sfunction\|public\sfunction'
command E let w:em=matchadd('ErrorMsg', '\%>130v.\+')
command E2 match ErrorMsg '\%>90v.\+'
command NE match ErrorMsg '\%>5000v.\+'
command NE2 matchdelete(em)
command O 3match OutputStatements '/^\s*var_dump\|^\s*echo\|^\s*printf'
command NO 3match none
command OO execute '/^\s*var_dump\|^\s*echo\|^\s*printf'
command H 2match ExtraWhiteSpace '\s\+$'
command NH 2match none
command HH execute '/\s\+$'
command MTD execute '/[a-z]\s(\|INFO\|TODO\|[a-z]([^ ^)]\|[^ ^(])'
command I set ignorecase
command NI set noignorecase
command K set list
command NK set nolist
command L set number
command NL set nonumber
command S set spell spelllang=en_us
command NS set nospell
command V set nowrap | match none | 2match none
command D set background=dark
command DE execute 'colorscheme default'
command VC execute 'colorscheme vividchalk'
command TW execute 'colorscheme twilight'
command CS execute 'colorscheme codeschool'
command DT execute 'colorscheme desert'
command CY execute 'colorscheme candy'

" Replace all characters on a line (except '-' and '#' with
" the character and a space. Then remove the space at the end
" of the line
" and turn of highlighting
command T execute 's/\(.\&[^-]\&[^#]\)/\1 /g  |  s/\s\+$//  |  noh'

" Set paste mode command
set pastetoggle=<F2>

" Delete current file and exit
command Remove echo delete(@%) | q!

" Set filetypes
au BufNewFile,BufRead *.mode set filetype=perl
au BufNewFile,BufRead *.ctl set filetype=perl

