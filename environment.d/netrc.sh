NETRC=$HOME/.private/

if [ -f "${NETRC}.netrc" ]; then
  export NETRC
else
  unset -v NETRC
fi
