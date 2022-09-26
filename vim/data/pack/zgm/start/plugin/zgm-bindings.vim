"-----------------------------------------------------------------------------
" custom vim keybindings
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

" ,fa toggles autoformatting [custom-commands.vim]
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

" ,FE changes to UTF-8 encoding
nmap <silent> <leader>FE :setlocal fenc=utf-8<CR>

" ,FF changes to LF line endings
nmap <silent> <leader>FF :setlocal ff=unix<CR>

" ,J squeezes multiple blank lines to one (TODO: fix w/ `cat -s`?)
" nmap <silent> <leader>J :g/^\s*$/,/\S/-j|s/.*//<CR>

" ,O opens up for a new paragraph (useful for email)
nmap <leader>O i<CR><CR><CR><CR><Esc>2ki

" ,P inserts a paragraph break
nmap <silent> <leader>P i<CR><CR><Esc>2k

" ,qD makes smart quotes (and other punctuation) dumb [custom-commands.vim]
nmap <silent> <leader>qD :call MakeQuotesDumb()<CR>

" ,S strips trailing whitespace [custom-commands.vim]
nmap <silent> <leader>S :StripTrailingWhitespaces<CR>

" ,WP rewraps current paragraph
nmap <leader>WP mzgqip`z

" ,WU unwraps entire file
nmap <silent> <leader>WU mz:UnwrapAll<CR>`z

" ,WW rewraps entire file
nmap <leader>WW mz1GgqG`z

" ,1 turns current line into a Markdown H1
nnoremap <leader>1 :set fo-=a<CR>yypVr=

" ,2 turns current line into a Markdown H2
nnoremap <leader>2 :set fo-=a<CR>yypVr-

" <F2> allows for pasting without an autoindent clusterfuck
set pastetoggle=<F2>

" <F5> quicksaves
map <silent> <F5> <C-O>:w!<CR>

" <F6> inserts the current date
map  <silent> <F6> "=strftime("%Y-%m-%d")<CR>p
imap <silent> <F6> <C-R>=strftime("%Y-%m-%d")<CR>

" <F9> toggles spellchecking
if has("spell")
  map  <silent> <F9> :set spell!<CR>
  imap <silent> <F9> <C-O>:set spell!<CR>
endif

" <F10> displays the current syntax highlighting context(s)
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Ctrl+[hjkl] moves b/w tabs and windows
map <silent> <C-j> :wincmd j<CR>
map <silent> <C-k> :wincmd k<CR>
map <silent> <C-l> :wincmd l<CR>
map <silent> <C-h> :wincmd h<CR>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %
