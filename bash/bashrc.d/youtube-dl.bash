# youtube-dl
# http://rg3.github.io/youtube-dl/

_inPath youtube-dl || return

if [[ ! -d $dir_cache/youtube-dl ]]; then
  mkdir -vp "$dir_cache/youtube-dl"
fi

ydl()
{
  local output_fmt="%(title)s.%(ext)s"
  youtube-dl -o "$dir_downloads/$output_fmt" "$@"
}
