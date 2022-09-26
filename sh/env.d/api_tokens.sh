# For each file in ~/dotfiles/private/tokens whose name matches `/^[A-Z_]+$/`,
# set a global exported variable with the name of the file and the value of its
# contents.
#
# To add a token:
# $ echo abcdefg1234567 > ~/dotfiles/private/tokens/FOO_API_KEY
for token_file in ~/dotfiles/private/tokens/*; do
  command grep -Eq '^[[:upper:]_]+$' <<< "$(basename "$token_file")" || continue
  [ -r "$token_file" ] && export "$(basename "$token_file")"="$(<"$token_file")"
done
