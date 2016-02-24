_inPath nethack || return

NETHACKOPTIONS="@$dir_config/nethackrc"

if [[ -f ${NETHACKOPTIONS#@} ]]; then
    export NETHACKOPTIONS
else
    unset NETHACKOPTIONS
fi
