# youtube-dl
# >> http://rg3.github.io/youtube-dl/

ydl()
{ #: - download video(s) to ~/Downloads
  _require youtube-dl || return

  # get output format from configuration file
  local output_fmt
  local config_file="$XDG_CONFIG_HOME/youtube-dl/config"
  output_fmt=$(sed -nE 's/^--output "([^"]+)".*/\1/p' "$config_file")

  youtube-dl -o "$dir_downloads/$output_fmt" "$@"
}

ydlq()
{ #: - download video(s) quietly in the background
  youtube-dl -q "$@" &
}
