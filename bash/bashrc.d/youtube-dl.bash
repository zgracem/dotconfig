# youtube-dl
# >> http://rg3.github.io/youtube-dl/

_inPath youtube-dl || return

ydl()
{ #: - download a video directly to ~/Downloads
  local output_fmt
  output_fmt=$(sed -nE 's/^--output "([^"]+)".*/\1/p' ~/.config/youtube-dl/config)
  youtube-dl -o "$dir_downloads/$output_fmt" "$@"
}
