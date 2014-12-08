# youtube-dl
# http://rg3.github.io/youtube-dl/

_inPath youtube-dl || return

export ydl_format='%(title)s.%(ext)s'

alias ydl='youtube-dl -o "${dir_downloads}/${ydl_format}"'
alias yydl='youtube-dl -o "${HOME}/Movies/YouTube/${ydl_format}"'
