" Set line endings to LF
setlocal ff=unix

" Don't auto-wrap text using textwidth
setlocal formatoptions-=t

" Preserve already-long lines
setlocal formatoptions+=l

" Don't format numbered lists w/ hanging indent
setlocal formatoptions-=n

" Insert comment leader on <CR> (Insert mode)
setlocal formatoptions+=r
