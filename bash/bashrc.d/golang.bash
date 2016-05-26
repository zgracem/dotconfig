# go-lang
# https://golang.org/doc/

_inPath go || return

case $OSTYPE in
  cygwin)
    GOROOT="/opt/go"
    GOPATH="${CYGWIN_HOME}${HOME}/Dropbox/src/go"
    ;;
  darwin*)
    GOROOT="/usr/local/opt/go/libexec"
    GOPATH="${HOME}/Dropbox/src/go"
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
