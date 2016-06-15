"-----------------------------------------------------------------------------
" Zozo's custom vim highlighting
"-----------------------------------------------------------------------------

" ┌─────────┬────┬────┬─────────┬────┬────┐
" │ colour  │  # │ br │ colour  │  # │ br │
" ├─────────┼────┼────┼─────────┼────┼────┤
" │ black   │  0 │  8 │ blue    │  4 │ 12 │
" │ red     │  1 │  9 │ magenta │  5 │ 13 │
" │ green   │  2 │ 10 │ cyan    │  6 │ 14 │
" │ yellow  │  3 │ 11 │ white   │  7 │ 15 │
" └─────────┴────┴────┴─────────┴────┴────┘

hi LineNr         ctermbg=0     ctermfg=7
hi CursorLine     ctermbg=0                 cterm=none
hi CursorLineNr   ctermbg=0     ctermfg=15

hi StatusLine     ctermbg=7     ctermfg=0   cterm=none
hi StatusLineNC   ctermbg=8     ctermfg=7   cterm=none
hi VertSplit      ctermbg=8     ctermfg=8

hi ErrorMsg       ctermbg=none  ctermfg=1
hi StatusLineErr  
                \ ctermbg=none  ctermfg=1   cterm=reverse

hi SpecialKey     ctermbg=0     ctermfg=13
hi NonText        ctermbg=none  ctermfg=13

hi IncSearch      ctermbg=3     ctermfg=15
hi Search         ctermbg=11    ctermfg=0
