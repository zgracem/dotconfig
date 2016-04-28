# youtube-dl
# http://rg3.github.io/youtube-dl/

_inPath youtube-dl || return

if [[ ! -d $HOME/var/cache/youtube-dl ]]; then
  mkdir -p "$HOME/var/cache/youtube-dl"
fi

ydl()
{
  local output_fmt="%(title)s.%(ext)s"
  youtube-dl -o "$dir_downloads/$output_fmt" "$@"
}
