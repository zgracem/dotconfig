# -----------------------------------------------------------------------------
# Erato:~/.local/init.bash
# -----------------------------------------------------------------------------

# cute login banner
if [[ -x $dir_scripts/loginbanner.sh ]]; then
    "${dir_scripts}/loginbanner.sh"
fi

# this day in history...
if [[ -x $dir_scripts/matins.sh ]]; then
    "${dir_scripts}/matins.sh"
fi

# countdown (date & function set in private.bash)
_isFunction cl && cl

# print bash version (~/.config/bash/functions.d/bashver.bash)
bashver



echo "*****************************************************"
echo "***          Check and then run esync.sh          ***"
echo "***    then remove this notice from init.bash     ***"
echo "*****************************************************"

