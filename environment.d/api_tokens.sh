for token_file in ~/.private/tokens/*; do
  command grep -Eq '^[[:upper:]_]+$' <<< "$token_file" || continue
  [ -r "$token_file" ] && export "$(basename "$token_file")"="$(<"$token_file")"
done
