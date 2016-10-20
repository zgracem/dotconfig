# StarDict
# http://sdcv.sourceforge.net/
# Used for Webster's access; see bash/functions.d/dictionary.bash

command -v sdcv >/dev/null || return

export STARDICT_DATA_DIR="$HOME/share/dict/stardict"
export SDCV_HISTSIZE=0
export SDCV_PAGER=$PAGER

# keep homedir tidy
[ -d "$HOME/.stardict" ] && rm -rfv "$HOME/.stardict"
[ -f "$HOME/.sdcv_history" ] && rm -fv "$HOME/.sdcv_history"
