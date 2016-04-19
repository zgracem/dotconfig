"-----------------------------------------------------------------------------
" ~/.config/vimrc
" vim: ft=vim:tw=0:sw=2:ts=2:sts=2
"-----------------------------------------------------------------------------

set nocompatible                " use vim settings, rather than vi settings

set runtimepath =$HOME/share/vim
set runtimepath+=$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after
set runtimepath+=$HOME/share/vim/after

set viminfo+=n~/var/lib/vim/.viminfo

silent! call pathogen#infect()
silent! call pathogen#helptags()

" clear all vimrc-related autocmds [http://ruderich.org/simon/config/vimrc]
if has("autocmd")
  augroup vimrc
    autocmd!
  augroup END
endif

"-----------------------------------------------------------------------------
" Preferences
"-----------------------------------------------------------------------------

set history=640                 " lots of history
set termencoding=utf-8          " Unicode terminal

" use strong encryption for :X
if exists("+cryptmethod")
  set cryptmethod=blowfish
endif

" spellcheck dictionaries
if has("spell")
  set spelllang=en_ca           " Canadian English
  set spellfile=$HOME/share/vim/spell/en.utf-8.add
endif

" paths
set path=.,$HOME
set cdpath=.,$HOME

" backups
set backup                      " do make backups
set backupcopy=yes              " copy/overwrite instead of renaming

if has("unix")
  set backupdir=$HOME/var/lib/vim,$TMPDIR
elseif has("win32") || has("win64")
  set backupdir=$HOME/var/lib/vim,$TEMP
endif

" swap files
set swapfile                    " make swapfiles
set updatecount=80              " update swapfile after x characters

if has("unix")
  set directory=.,$HOME/var/lib/vim//,$TMPDIR//
elseif has("win32") || has("win64")
  set directory=.,$HOME/var/lib/vim//,$TEMP//
endif

" // = include path in name of swap file

"-----------------------------------------------------------------------------
" Behaviour
"-----------------------------------------------------------------------------

let mapleader=","               " use `,` as leader
set autoread                    " reload files changed outside vim
set confirm                     " ask instead of aborting
set hidden                      " don't unload abandoned buffers
set noerrorbells                " shut up
set shortmess+=I                " don't display startup message
set visualbell t_vb=            " really, shut up

" autocompletion
if has("wildmenu")
  set wildmenu                  " show all matches for command completion
  set wildmode=list:longest,full " complete only to the point of ambiguity
  set wildignore=*.jpg,*.gif,*.png,*.tif,
  set wildignore+=*.mp3,*.m4a,
  set wildignore+=*.swp,*~,
endif

" mousing
if has("mouse")
  " set mouse=a                 " to enable mouse in all modes
  set mouse=""                  " disable mouse
  set ttymouse=xterm2           " xterm-style mouse + enable dragging
  if has("gui_running")
    set mousehide               " hide pointer when typing
    set mousemodel=popup_setpos " right-click moves cursor + opens menu
  endif
endif

" searching
set ignorecase                  " case-insensitive
set smartcase                   " ...unless the pattern is mixed-case
set incsearch                   " incremental
set wrapscan                    " searches wrap around the end of the file
set shortmess+=s                " don't notify when search wraps
set hlsearch                    " highlight last pattern
silent! set cpoptions+=;        " skip current char when ;-repeating a t-search
set gdefault                    " apply substitutions globally on lines

" use normal regexes
nnoremap / /\v
vnoremap / /\v

"-----------------------------------------------------------------------------
" Editing
"-----------------------------------------------------------------------------

set backspace=indent,eol,start  " backspace over everything in insert mode
set undolevels=640              " lots of undo
set fileformats=unix            " LF line endings
set encoding=utf-8              " Unicode files
set tildeop                     " tilde behaves like an operator

" wrapping
set wrap                        " visually wrap long lines
set linebreak                   " visually break at word boundaries
set textwidth=78                " force EoL after < x chars

set nojoinspaces                " two spaces after sentences is an abomination
set formatoptions+=n            " format numbered lists w/ hanging indent
set formatoptions+=1            " break before one-letter words where possible
set formatoptions-=o            " [don't] comment new lines opened with o/O
set formatoptions+=q            " gq can format comments

" indentation
set autoindent
set expandtab                   " use spaces, not tabs
set smarttab                    " backspace over blanks at BoL

" tabs
set tabstop=4                   " shouldn't matter
set shiftwidth=4
set softtabstop=4
set shiftround                  " always indent to a multiple of 4

"-----------------------------------------------------------------------------
" Appearance
"-----------------------------------------------------------------------------

set cursorline                  " highlight current line
set lazyredraw                  " don't redraw screen while executing macros
set number                      " display line numbers
if v:version >= 703
  set relativenumber            " ...relative to current line
endif
set scrolloff=3                 " keep x lines of context at edge of screen
set showcmd                     " display partial commands
set splitright                  " open new vertical panes to the right
set ttyfast                     " faster redraw
set winminheight=0              " windows can be 0 lines high
set cmdheight=2                 " fewer "Press ENTER to continue" messages

set listchars=eol:¶,tab:→\ ,trail:·,extends:»,precedes:«,nbsp:¬

" disable concealing
if v:version >= 703
  set conceallevel=0
  let g:vim_json_syntax_conceal = 0
endif

if $TERM_PROGRAM == "iTerm.app"
  if expand($TMUX) != ""
    let &t_SI = "\<Esc>[3 q"
    let &t_EI = "\<Esc>[0 q"
  else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  endif
endif

"-----------------------------------------------------------------------------
" Colours and syntax highlighting
"-----------------------------------------------------------------------------

set t_Co=256                    " use 256-colour display
set t_ut=                       " disable BCE

syntax on                       " syntax highlighting
filetype plugin indent on       " filetype detection + plugins + indent prefs

if $Z_SOLARIZED == "light" && ! has("gui_running")
  set background=light
else
  set background=dark
endif

if $Z_SOLARIZED == "light" || $Z_SOLARIZED == "dark"
  let g:solarized_termtrans=1     " use proper solarized bg colour
  silent! colorscheme solarized
endif

let g:is_bash=1                 " default shell for syntax highlighting

"-----------------------------------------------------------------------------
" Window title and status line
"-----------------------------------------------------------------------------

if has("statusline")
  " window title -- ### ZGM disabled 2015-09-10
  " set title

  if has("gui_running")
    " set titlestring=
  else
    let &titleold = expand("$USER") . "@" . expand("$HOSTNAME") " . ": " . expand("$PWD")
    " set titlestring=
  endif

  " set titlestring+=%(%h\ %)     " help flag
  " set titlestring+=%F           " full path to file
  " set titlestring+=%(\ [%M%R]%) " modified/readonly flags

  if $TERM_PROGRAM == "Apple_Terminal"
    let &t_ts = "]6;"
    let &t_fs = ""
    " set title
    " let &titlestring = "file://" . expand("$HOSTNAME") . UrlEncode("%F")
  elseif expand($TMUX) != ""
    let &t_ts = "\<Esc>Ptmux;\<Esc>\<Esc>]0;"
    let &t_fs = "\<Esc>\\"
  elseif &term =~ "screen"
    let &t_ts = "\<Esc>P\<Esc>]0;"
    let &t_fs = "\<Esc>\\"
  endif

  " status line
  set laststatus=2                " always show statusline (overrides ruler)

  " set statusline=%<%t\          " tail of the filename, front-truncated
  set statusline=%F\              " full path to file
  set statusline+=%([%M%R]%)      " modified & readonly flags

  set statusline+=%=              " start of right side

  " display a warning if file encoding isn't utf-8
  set statusline+=%#StatusLineErr#
  set statusline+=%(%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}%*\ %)
  set statusline+=%*

  " display a warning if fileformat != unix
  set statusline+=%#StatusLineErr#
  set statusline+=%(%{&ff!='unix'?'['.&ff.']':''}%*\ %)
  set statusline+=%*

  " filetype
  set statusline+=%y

  " cursor position + percentage through file
  set statusline+=\ %l,%c%V
  set statusline+=\ %5.(%3.p%%\ %)
endif

"-----------------------------------------------------------------------------
" GUI
"-----------------------------------------------------------------------------

if has("gui_running")
  set columns=167
  set lines=52

  set guioptions+=a             " use "* in visual mode (system clipboard)
  set guioptions+=c             " use console dialogs for simple choices
  set guioptions-=m             " no menu
  set guioptions-=r             " no right-hand scrollbar
  set guioptions-=L             " no left-hand scrollbar either
  set guioptions-=T             " no toolbar

  set guicursor=a:blinkoff0-block

  set clipboard=unnamed

  " Windows fonts
  if has('win32') || has('win64')
    set guifont=Consolas:h10,Courier\ New:h10
  endif

  " OS X fonts
  if has("unix")
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
    set guifont=Consolas:h12,Menlo:h12
    endif
  endif
endif

"-----------------------------------------------------------------------------
" Filetypes
"-----------------------------------------------------------------------------

if exists("#vimrc")
  augroup vimrc
    " default to plain text
    autocmd BufNewFile * if &ff == "dos" | setlocal ff=unix | endif
    " ↑ why doesn't this work on Win32 gvim? :(
    autocmd BufEnter * if &filetype == "" | setlocal ft=text | endif

    " formatoptions etc.
    autocmd FileType conf,dosini,javascript,sh,vim
      \ setlocal ff=unix fo+=l fo+=r fo-=t fo-=n
    autocmd FileType css,html
      \ setlocal ff=unix fo+=l noet
    autocmd FileType crontab
      \ setlocal fo+=l fo-=t sw=8 sts=8 ts=8 noet nowrap backupcopy=yes
    autocmd FileType mail
      \ setlocal fo+=la
    autocmd FileType markdown,text
      \ setlocal fo+=ta

    " journaling
    autocmd BufNewFile,BufRead draft_[0-9]*,750words-201*,jrnl*.txt,dayone*.md
      \ setlocal ft=markdown fo-=t fo-=a fo-=c textwidth=0

    " poetry
    autocmd BufNewFile,BufRead */p/[1-4]*/*.txt
      \ setlocal ft=markdown fo-=t fo-=a
  augroup END
endif

"-----------------------------------------------------------------------------
" Autocmd's and functions
"-----------------------------------------------------------------------------

if exists("#vimrc")
  augroup vimrc

    " strip trailing whitespace on save
    autocmd FileType html,css,js,sh
      \ autocmd BufWritePre <buffer> :StripTrailingWhitespaces

  augroup END
endif

"-----------------------------------------------------------------------------
" man pages
"-----------------------------------------------------------------------------

if exists("#vimrc")
  augroup man
    " Ensure man-db won't recursively invoke vim when ^['ing manpage references
    " http://www.pixelbeat.org/settings/.vimrc
    autocmd FileType man let $MANPAGER=""
    autocmd FileType man set notitle
  augroup END
endif

"-----------------------------------------------------------------------------
" Remapping
"-----------------------------------------------------------------------------

" page down with the space bar (thanks, 15 years of muscle memory)
map <Space> <PageDown>

" because I am a masochist
map  <up>    <nop>
map  <down>  <nop>
map  <left>  <nop>
map  <right> <nop>
imap <up>    <nop>
imap <down>  <nop>
imap <left>  <nop>
imap <right> <nop>

" keep the cursor in place when joining lines
nnoremap <silent> J mzJ`z

" move by screen rows instead of file lines
nnoremap j gj
nnoremap k gk
nnoremap ^ g^
nnoremap 0 g0
nnoremap $ g$

nnoremap gj j
nnoremap gk k
nnoremap g^ ^
nnoremap g0 0
nnoremap g$ $

" use <Tab> to hop between brackets
nnoremap <tab> %
vnoremap <tab> %

" swap 0 and ^
nnoremap 0 ^
nnoremap ^ 0

" swap p and P
nnoremap p P
nnoremap P p

" I never use Ex mode, but I sure do start a lot of macros by accident
nnoremap q <nop>
nnoremap Q q

"-----------------------------------------------------------------------------
" Key bindings
"-----------------------------------------------------------------------------

" ,fa toggles autoformatting
nmap <silent> <leader>fa :call FOtoggleA()<CR>

" ,h hides highlighting
nmap <silent> <leader>h :nohlsearch<CR>

" ,md changes filetype to Markdown
nmap <silent> <leader>md :set filetype=markdown<CR>

" ,s makes tabs and trailing spaces visible
nmap <silent> <leader>s :set nolist!<CR>

" ,ve edits .vimrc
nmap <silent> <leader>ve :vs $MYVIMRC<CR>

" ,vE edits .vimrc only
nmap <silent> <leader>vE :vs $MYVIMRC<CR>:only<CR>

" ,vr reloads .vimrc
nmap <silent> <leader>vr :source $MYVIMRC<CR>

" ,w gets word count
nnoremap <leader>w g<C-G>

" ,B = "break here instead" (useful for poetry)
nnoremap <leader>B mzJ`zF<Space>r<CR><Esc>

" ,E unwraps, yanks entire file, rewraps
if has("gui_running") || system("uname") == "Darwin\n"
    nmap <silent> <leader>E :UnwrapAll<CR>:normal gg"*yGgqG<CR>
  else
    nmap <silent> <leader>E :UnwrapAll<CR>:
endif

" ,FE changes to UTF-8 encoding
nmap <silent> <leader>FE :setlocal fenc=utf-8<CR>

" ,FF changes to LF line endings
nmap <silent> <leader>FF :setlocal ff=unix<CR>

" ,J squeezes multiple blank lines to one (broken)
" nmap <silent> <leader>J :g/^\s*$/,/\S/-j|s/.*//<CR>

" ,O opens up for a new paragraph (useful for email)
nmap <leader>O i<CR><CR><CR><CR><Esc>2ki

" ,P inserts a paragraph break
nmap <silent> <leader>P i<CR><CR><Esc>2k

" ,qD makes smart quotes (and other punctuation) dumb
nmap <silent> <leader>qD :call MakeQuotesDumb()<CR>

" ,S strips trailing whitespace
nmap <silent> <leader>S :StripTrailingWhitespaces<CR>

" ,WP rewraps current paragraph
nmap <leader>WP mzgqip`z

" ,WU unwraps entire file
nmap <silent> <leader>WU mz:UnwrapAll<CR>`z

" ,WW rewraps entire file
nmap <leader>WW mz1GgqG`z

" ,X saves and executes the file
nmap <silent> <leader>X :w\|:!./%<CR>

" ,1 creates a Markdown H1
nnoremap <leader>1 :set fo-=a<CR>yypVr=

" ,2 creates a Markdown H2
nnoremap <leader>2 :set fo-=a<CR>yypVr-

" <F2> allows for pasting without an autoindent clusterfuck
set pastetoggle=<F2>

" <F5> quicksaves
map <silent> <F5> <C-O>:w!<CR>

" <F6> inserts the current date
map  <silent> <F6> "=strftime("%Y-%m-%d")<CR>P
imap <silent> <F6> <C-R>=strftime("%Y-%m-%d")<CR>

" <F9> toggles spellchecking
if has("spell")
  map  <silent> <F9> :set spell!<CR>
  imap <silent> <F9> <C-O>:set spell!<CR>
endif

" Ctrl+[hjkl] moves b/w tabs and windows
map <silent> <C-j> :wincmd j<CR>
map <silent> <C-k> :wincmd k<CR>
map <silent> <C-l> :wincmd l<CR>
map <silent> <C-h> :wincmd h<CR>

" Ctrl+[arrow] moves windows
map <silent> <C-Down>  :wincmd J<CR>
map <silent> <C-Up>    :wincmd K<CR>
map <silent> <C-Right> :wincmd L<CR>
map <silent> <C-Left>  :wincmd H<CR>

" text bubbling (w/ tpope's vim-unimpaired)
nmap <C-S-k> [e
nmap <C-S-j> ]e

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

"-----------------------------------------------------------------------------
" Abbreviations
"-----------------------------------------------------------------------------

abbr #div\ # ----------------------------------------------------------------------------<CR>
abbr #box\ # ----------------------------------------------------------------------------<Esc>yyPO#
abbr "box\ "-----------------------------------------------------------------------------<Esc>yyPO"

" 2012-12-21
abbr tdy <C-R>=strftime("%Y-%m-%d")<CR>

abbr +/-    <C-K>+-
abbr ?x     <C-K>*X
abbr ssec   <C-K>SE
abbr ppara  <C-K>PI
abbr ddeg   <BS><C-K>DG
abbr mdd    <C-K>.M
abbr 8th\   <C-K>u266a
abbr 8ths\  <C-V>u266b
abbr sstar  <C-V>u2605
abbr ccheck <C-V>u2713
abbr nnd    <BS><C-V>u2013
abbr mmd    <BS><C-V>u2014
abbr <<-    <C-V>u2190
abbr ->>    <C-V>u2192
abbr ?-     <C-V>u2212

" -------- Solarized --------
"  8 = base03   3 = yellow
"  0 = base02   9 = orange
" 10 = base01   1 = red
" 11 = base00   5 = magenta
" 12 = base0   13 = violet
" 14 = base1    4 = blue
"  7 = base2    6 = cyan
" 15 = base3    2 = green
" ---------------------------

if expand($Z_SOLARIZED) != ""
  if &background == "dark"
    hi LineNr                      ctermbg=8     ctermfg=10
    hi CursorLine    cterm=none    ctermbg=0
    hi CursorLineNr                ctermbg=0     ctermfg=14

    hi StatusLine    cterm=reverse ctermbg=0     ctermfg=12
    hi StatusLineNC  cterm=reverse ctermbg=0     ctermfg=10
    hi VertSplit     cterm=none    ctermbg=10    ctermfg=10

    hi SpecialKey    cterm=none    ctermbg=0     ctermfg=5
    hi NonText       cterm=none                  ctermfg=13

    hi ErrorMsg      cterm=none                  ctermfg=1

    hi IncSearch     cterm=reverse ctermbg=8     ctermfg=9
    hi Search        cterm=reverse ctermbg=8     ctermfg=3

    hi htmlItalic    cterm=none                  ctermfg=7
  endif

  if &background == "light"
    hi LineNr                      ctermbg=15
    hi CursorLine    cterm=none    ctermbg=7
    hi CursorLineNr                ctermbg=7     ctermfg=0

    hi markdownItalic cterm=none   ctermbg=15    ctermfg=0
  endif
endif

"-----------------------------------------------------------------------------

hi CursorLine    gui=none      guibg=#073642
hi CursorLineNr  gui=none      guibg=#073642 guifg=#93a1a1
hi LineNr        gui=none      guibg=#002b36 guifg=#586e75

hi SpecialKey    gui=none      guibg=#002b36 guifg=#d33682
hi NonText                     guibg=#002b36 guifg=#6c71c4

hi ErrorMsg      gui=none

"-----------------------------------------------------------------------------

hi! link StatusLineErr StatusLine
hi StatusLineErr cterm=none    ctermbg=1     ctermfg=8
hi StatusLineErr gui=none      guibg=#dc322f guifg=#002b36
