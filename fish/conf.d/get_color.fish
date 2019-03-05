function get_color --description 'Get the partial escape code for a terminal colour'
  switch $argv[1]
  case normal
    echo "0"
  case '*'
    set_color $argv \
    | string split \x1b \
    | string replace -afr '\[(\d+)m' '$1' \
    | string join ';'
  end
end
