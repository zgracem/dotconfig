function get_color --description 'Get the partial escape code for a terminal colour'
  set_color $argv \
  | string split \x1b \
  | string replace -afr '\[(\d+)m' '$1' \
  | string join ';'
end
