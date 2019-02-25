function manpdf
	set -lx MANPDF_DIR "$XDG_DATA_HOME/doc/pdf"
  if [ ! -d "$MANPDF_DIR" ]
    set MANPDF_DIR "$HOME/Dropbox/share/doc/pdf"
  end
  set -l pdf (command manpdf $argv); or return $status
  if [ (string sub -l 1 "$pdf") != "/" ]
    echo "$pdf"
    return 0
  else if [ -n "$SSH_CONNECTION" ]
    echo "$pdf"
  else
    open "$pdf"
  end
end
