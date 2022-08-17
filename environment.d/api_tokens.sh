for token_file in ~/.private/tokens/*; do
  [ -r "$token_file" ] && export "$(basename "$token_file")"="$(<"$token_file")"
done
