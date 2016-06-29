# For my manpdf script.
export MANPDF_DIR="$HOME/share/man/pdf"

manpdf()
{
  local pdf; pdf=$(command manpdf "$@") && open "$pdf";
}
