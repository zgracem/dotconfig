NETHACKOPTIONS="@$XDG_CONFIG_HOME/nethack/nethackrc"

if [ -f "${NETHACKOPTIONS#@}" ]; then
  export NETHACKOPTIONS
else
  unset -v NETHACKOPTIONS
fi
