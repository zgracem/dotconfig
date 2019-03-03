function manpdf
  # https://github.com/zgracem/manpdf
  in-path manpdf; or return 127

  set -lx MANPDF_DIR "$XDG_DATA_HOME/doc/pdf"
  if test ! -d "$MANPDF_DIR"
    set MANPDF_DIR "$HOME/Dropbox/share/doc/pdf"
  end
  set -l pdf (command manpdf $argv); or return $status
  if string match -q "/*" "$pdf"
    echo "$pdf"
    return 0
  else if test -n "$SSH_CONNECTION"
    echo "$pdf"
  else
    open "$pdf"
  end
end
