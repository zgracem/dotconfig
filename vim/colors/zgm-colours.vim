"-----------------------------------------------------------------------------
" custom vim highlighting
"-----------------------------------------------------------------------------

" ╔═════════╤═══╤════╦═════════╤═══╤════╗
" ║ colour  │ # │ br ║ colour  │ # │ br ║
" ╟─────────┼───┼────╫─────────┼───┼────╢
" ║ black   │ 0 │  8 ║ blue    │ 4 │ 12 ║
" ║ red     │ 1 │  9 ║ magenta │ 5 │ 13 ║
" ║ green   │ 2 │ 10 ║ cyan    │ 6 │ 14 ║
" ║ yellow  │ 3 │ 11 ║ white   │ 7 │ 15 ║
" ╚═════════╧═══╧════╩═════════╧═══╧════╝

" the screen line that the cursor is in
hi CursorLine     ctermbg=0                 cterm=none

" line numbers in left-side gutter
hi LineNr         ctermbg=none  ctermfg=8
hi CursorLineNr   ctermbg=0     ctermfg=15

" status line of current window
hi StatusLine     ctermbg=7     ctermfg=0   cterm=none

" status line of not-current windows
hi StatusLineNC   ctermbg=8     ctermfg=7   cterm=none

" the column separating vertically split windows
hi VertSplit      ctermbg=8     ctermfg=8

" error messages on the command line
hi ErrorMsg       ctermbg=none  ctermfg=9

" error messages on the status line? (not documented)
hi StatusLineErr  ctermbg=none  ctermfg=1   cterm=reverse

" meta, special, and unprintable characters
hi SpecialKey     ctermbg=0     ctermfg=13

" characters that don't really exist in the text
hi NonText        ctermbg=none  ctermfg=6

" matching brackets
hi MatchParen     ctermbg=none  ctermfg=5

" search-as-you-type highlighting
hi IncSearch      ctermbg=3     ctermfg=15  cterm=none

" last search pattern & other standout text
hi Search         ctermbg=11    ctermfg=0

" 'showmode' message (e.g., "-- INSERT --")
hi ModeMsg        ctermbg=none  ctermfg=4   cterm=none

" more-prompt; hit-enter prompt and yes/no questions
hi MoreMsg        ctermbg=none  ctermfg=6  cterm=none
hi! link Question MoreMsg

" folded text
hi Folded         ctermbg=none  ctermfg=8

"-----------------------------------------------------------------------------
" Markdown
"-----------------------------------------------------------------------------

hi markdownItalic ctermbg=none  ctermfg=15

"-----------------------------------------------------------------------------
" diff mode
"-----------------------------------------------------------------------------

" Added line
hi DiffAdd        ctermbg=0     ctermfg=10  cterm=none

" Deleted line
hi DiffDelete     ctermbg=none  ctermfg=1   cterm=none

" Changed line
hi DiffChange     ctermbg=0     ctermfg=none

" Changed text within a changed line
hi DiffText       ctermbg=8     ctermfg=7   cterm=bold

"-----------------------------------------------------------------------------
" spellcheck
"-----------------------------------------------------------------------------

" misspelled
hi SpellBad       ctermbg=none  ctermfg=1   cterm=undercurl

" rare/regional word, possibly a typo
hi SpellRare      ctermbg=none  ctermfg=4   cterm=undercurl
hi! link SpellLocal SpellRare

" should be capitalized
hi SpellCap       ctermbg=none  ctermfg=2   cterm=undercurl
