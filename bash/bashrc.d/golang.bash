# go-lang
# https://golang.org/doc/

_inPath go || return

case $OSTYPE in
  cygwin)
    GOROOT="/opt/go"
    GOPATH="${CYGWIN_HOME}${HOME}/opt/go"
    ;;
  darwin*)
    GOROOT="/usr/local/opt/go/libexec"
    GOPATH="${HOME}/opt/go"
    ;;
  *)
    return
    ;;
esac

if [[ -x $GOROOT/bin/go ]]; then
  export GOROOT
else
  unset -v GOROOT
fi

if [[ -d $GOPATH ]]; then
  export GOPATH
  GOBIN="${GOPATH}/bin"

  if [[ -d $GOBIN ]]; then
    export GOBIN
  else
    unset -v GOBIN
  fi
else
  unset -v GOPATH
fi
