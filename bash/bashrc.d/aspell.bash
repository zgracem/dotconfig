if [[ -d $XDG_DATA_HOME/aspell ]]; then
  # >> http://aspell.net/0.61/man-html/Specifying-Options.html
  ASPELL_CONF="$(envsubst < "$dir_config/aspell.conf" 2>/dev/null | tr '\n' ';')"
  if [[ -n $ASPELL_CONF ]]; then
    export ASPELL_CONF
  else
    unset -v ASPELL_CONF
  fi
fi
