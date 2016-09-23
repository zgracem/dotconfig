command -v nethack >/dev/null || return

NETHACKOPTIONS="@$HOME/.config/nethackrc"

if [ -f "${NETHACKOPTIONS#@}" ]; then
  export NETHACKOPTIONS
else
  unset -v NETHACKOPTIONS
fi
