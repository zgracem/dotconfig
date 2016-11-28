# youtube-dl
# >> http://rg3.github.io/youtube-dl/

_inPath youtube-dl || return

ydl()
{
  local output_fmt="%(title)s.%(ext)s"
  youtube-dl -o "$dir_downloads/$output_fmt" "$@"
}
