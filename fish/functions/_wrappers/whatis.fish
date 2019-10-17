function _whatis --description 'Display one-line manual page descriptions' --argument-names term
  set -l args $argv[2..-1]
  set -l output (command whatis --regex '\b'"$term"'\b[^-]' $args 2>/dev/null | sort -u)
  test -n "$output"; or return 16

  # Collapse needless whitespace in $output
  string replace -ar '\s+' ' ' $output
end

if in-path gwhatis
  function whatis --wraps gwhatis; _whatis $argv; end
else
  function whatis --wraps whatis; _whatis $argv; end
end
