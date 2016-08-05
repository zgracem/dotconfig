# For my manpdf script.
export MANPDF_DIR="$HOME/share/man/pdf"

manpdf()
{
  local pdf; pdf=$(command manpdf "$@") || return

  if [[ -n $SSH_CONNECTION ]]; then
    echo "$pdf"
  else
    open "$pdf"
  fi
}
