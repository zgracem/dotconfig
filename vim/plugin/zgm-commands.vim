"-----------------------------------------------------------------------------
" custom vim commands
"-----------------------------------------------------------------------------

"-----------------------------------------------------------------------------
" see the difference between the current buffer and the file it was loaded from
"-----------------------------------------------------------------------------

if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

"-----------------------------------------------------------------------------
" show syntax highlighting groups for word under cursor
" >> http://vimcasts.org/episodes/creating-colorschemes-for-vim/
"-----------------------------------------------------------------------------

function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

nmap <C-S-P> :call <SID>SynStack()<CR>

"-----------------------------------------------------------------------------
" make smart quotes (etc.) dumb
"-----------------------------------------------------------------------------

function! MakeQuotesDumb()
    %s/[“”″]/"/gge
    %s/[‘’′]/'/gge
    %s/ \?[—] \?/ -- /gge
    %s/[–]/-/gge
    %s/[…]/.../gge
    nohlsearch
endfunction

"-----------------------------------------------------------------------------
" unwrap entire file (preserve paragraph breaks)
"-----------------------------------------------------------------------------

function! UnwrapAll()
    %s#\(\S\)\n\(\S\)#\1 \2#g
    nohlsearch
endfunction

command! UnwrapAll call UnwrapAll()

"-----------------------------------------------------------------------------
" toggle auto-formatting
"-----------------------------------------------------------------------------

function! FOtoggleA()
  if &fo =~ 'a'
    set fo-=a
  else
    set fo+=a
  endif
endfunction

"-----------------------------------------------------------------------------
" strip trailing whitespace
" >> http://rails-bestpractices.com/posts/60-remove-trailing-whitespace
"-----------------------------------------------------------------------------

function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
command! StripTrailingWhitespaces call <SID>StripTrailingWhitespaces()

" -----------------------------------------------------------------------------

function! UrlEncode(str)
  let i = 0
  let repl = ""
  while i < strlen(a:str)
    let repl  = repl . printf("%%%02X",char2nr(strpart(a:str,i,1)))
    let i = i + 1
  endwhile
  return repl
endfunction
