# youtube-dl
# >> http://rg3.github.io/youtube-dl/
_inPath youtube-dl || return

ydl()
( #: - download video(s) to ~/Downloads
  cd "$XDG_DOWNLOAD_DIR" && youtube-dl "$@"
)

ydlq()
{ #: - download video(s) quietly in the background
  youtube-dl -q "$@" &
}
