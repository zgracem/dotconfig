# If `gwhatis` is present, that's the one whose completions we want to use.
# No need to worry about executing it; there's a shadow `whatis` link in PATH.
set cmd 'whatis'; in-path gwhatis; and set cmd 'gwhatis'

function whatis -a term --wraps $cmd --description 'Search the whatis database for exact matches'
  set -l args $argv[2..-1]
  set -l output (command whatis --regex '\b'"$term"'\b[^-]' $args 2>/dev/null | sort -u)
  test -n "$output"; or return 16

  # Collapse needless whitespace in $output
  string replace -ar '\s+' ' ' $output
end

set --erase cmd
