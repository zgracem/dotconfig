NETRC=$XDG_CONFIG_HOME/

if [ -f "$NETRC/.netrc" ]; then
  export NETRC
else
  unset -v NETRC
fi
