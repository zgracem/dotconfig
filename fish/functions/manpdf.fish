function manpdf
	set -x MANPDF_DIR "$XDG_DATA_HOME/doc/pdf"
  if not test -d "$MANPDF_DIR"
    set MANPDF_DIR "$HOME/Dropbox/share/doc/pdf"
  end
  set pdf (command manpdf $argv); or return $status
  if test (string sub -l 1 "$pdf") != "/"
    echo "$pdf"
    return 0
  else if test -n "$SSH_CONNECTION"
    echo "$pdf"
  else
    open "$pdf"
  end
end
