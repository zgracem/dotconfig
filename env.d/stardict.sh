# StarDict
# >> http://sdcv.sourceforge.net/
# Used for Webster's access; see bash/functions.d/webster.bash

if command -v sdcv >/dev/null; then
  # defaults to /usr/share/stardict || ~/.stardict
  export STARDICT_DATA_DIR="$XDG_DATA_HOME/dict/stardict"
  export SDCV_HISTSIZE=0
  export SDCV_PAGER="$PAGER"
fi
