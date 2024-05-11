" Set line endings to LF
setlocal ff=unix

" Preserve already-long lines
setlocal formatoptions+=l

" Strip trailing whitespace on save
autocmd BufWritePre <buffer> :StripTrailingWhitespaces
