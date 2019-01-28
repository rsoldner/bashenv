" DISABLE ARROW KEYS (breaking the bad habits)
noremap <Up>    :echom 'You have no power here! --Theoden https://www.youtube.com/watch?v=fBGWtVOKTkM'<CR>
noremap <Down>  :echom 'I am looking forward to completing your training. In time you will call *me* master. --Emperor Palpatine'<CR>
noremap <Left>  :echom 'Never send a human to do a machines job. --Agent Smith'<CR>
noremap <Right> :echom 'The cake is a lie! --portal'<CR>

" Highlight text in Visual mode then type // to search for it
vnoremap // y/<C-R>"<CR>


" Use Vim settings, rather than Vi settings
set nocompatible

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Do not keep a backup file, they just clutter the file system
set nobackup

" Turn on hidden buffers
set hidden

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

" Displays list when using autocomplete in command menu
set wildmenu

" Redraw only when needed (speeds up macros)
set lazyredraw

" Remove octal from Ctrl-A
set nrformats=hex

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

" Change the color schema when using vimdiff
if( &diff )
    colorscheme vividchalk

    " Move the cursor to the first change
    if has('autocmd')
        autocmd VimEnter * execute "normal gg"
        autocmd VimEnter * execute "normal ]c"
    endif
endif

" Set tab behavior
set tabstop=4
set expandtab
set shiftwidth=4

" override tab setting for javascript and html files
" Decided to keep 4 spaces as indent (2018-08-13)
"autocmd BufRead,BufNewFile  *.js,*.html,*/view/*.php,*.htm, set ts=2 sw=2
autocmd BufRead,BufNewFile  *.vue set syntax=html


" Highlight trailing whitespace
highlight ExtraWhitespace  ctermbg=2;
highlight TurquoiseMatch   ctermbg=45;
highlight DiffText         ctermbg=DarkRed
highlight DiffText         cterm=bold ctermbg=52 gui=bold guibg=Red

" Highlight long lines
match ErrorMsg '\%>120v.\+'
2match ExtraWhiteSpace '\s\+$'



" Custom commands
command PERL set syntax=perl
command FN execute 'g/private\sfunction\|public\sfunction'
command OO execute '/^\s*var_dump\|^\s*echo\|^\s*printf'
command HH execute '/\s\+$'
command MTD execute '/[a-z]\s(\|INFO\|TODO\|[a-z]([^ ^)]\|[^ ^(])'
command V set nowrap | match none | 2match none

function! HTML()
    set syntax=html
    set noautoindent
    set tabstop=2
    set expandtab
    set shiftwidth=2
endfunction

command HTML call HTML()

" Highlight trailing whitespace
" And command to enable/disable
highlight ExtraWhiteSpace ctermbg=2;
2match ExtraWhiteSpace '\s\+$'
command H
    \ let match = matcharg(2) |
    \ if match[1] == '\s\+$' |
    \   2match none |
    \ else |
    \   2match ExtraWhiteSpace '\s\+$' |
    \ endif

" Background toggle
command D
    \ if &background == 'dark' |
    \     set background=light |
    \ else |
    \     set background=dark |
    \ endif

" Long Line Highlight toggle
command E
    \ let match = matcharg(1) |
    \ if match[1] == '\%>120v.\+' |
    \     match none |
    \ else |
    \     match ErrorMsg '\%>120v.\+' |
    \ endif

"Mouse Control
command M
    \ if &mouse == 'a' |
    \     set mouse-=a |
    \ else |
    \     if has('mouse') |
    \         set mouse=a |
    \     endif |
    \ endif

" Ignore Case toggle
command I
    \ if &ignorecase |
    \     set noignorecase |
    \ else |
    \     set ignorecase |
    \ endif

" List toggle
command K
    \ if &list |
    \     set nolist |
    \ else |
    \     set list |
    \ endif

" Number toggle
command L
    \ if &number |
    \     set nonumber |
    \ else |
    \     set number |
    \ endif

" Spell Check toggle
command S
    \ if &spell |
    \     set nospell |
    \ else |
    \     set spell spelllang=en_us |
    \ endif

" Spell Check toggle
command R
    \ if &rnu |
    \     set nornu |
    \ else |
    \     set rnu |
    \ endif

" Color commands
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
au BufNewFile,BufRead *.thpl set filetype=perl
au BufNewFile,BufRead *.t set syntax=perl
