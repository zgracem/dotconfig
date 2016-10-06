command -v nethack >/dev/null || return

NETHACKOPTIONS="@$XDG_CONFIG_HOME/nethackrc"

if [ -f "${NETHACKOPTIONS#@}" ]; then
  export NETHACKOPTIONS
else
  unset -v NETHACKOPTIONS
fi
