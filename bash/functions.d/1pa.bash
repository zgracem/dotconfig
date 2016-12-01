# Launcher for 1PasswordAnywhere
1pa()
{
  local opa_file="$dir_dropbox/Apps/1PasswordSync/1Password.agilekeychain/1Password.html"
  local opa_url="file:///$(cygpath -am "$opa_file")"

  chrome \
    --allow-file-access \
    --allow-file-access-from-files \
    --incognito --user-data-dir="$(cygpath -aw "$TMPDIR")" \
    "$opa_url"
}
