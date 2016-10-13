# youtube-dl
# http://rg3.github.io/youtube-dl/

_inPath youtube-dl || return

# see also `--cache-dir` and `--cookies` settings in youtube-dl.conf
[[ -d $XDG_CACHE_HOME/youtube-dl ]] || mkdir -vp "$XDG_CACHE_HOME/youtube-dl"

ydl()
{
  local output_fmt="%(title)s.%(ext)s"
  youtube-dl -o "$dir_downloads/$output_fmt" "$@"
}
