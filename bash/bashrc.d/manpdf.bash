# For my manpdf script.
export MANPDF_DIR="$XDG_DATA_HOME/doc/pdf"

if [[ ! -d $MANPDF_DIR ]]; then
  MANPDF_DIR="$HOME/Dropbox/share/doc/pdf"
fi

manpdf()
{
  local pdf
  pdf=$(command manpdf "$@") || return

  # Because `manpdf -h` produces a non-filename but exits 0
  [[ ${pdf:0:1} == "/" ]] || return

  if [[ -n $SSH_CONNECTION ]]; then
    echo "$pdf"
  else
    open "$pdf"
  fi
}
