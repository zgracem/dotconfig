# Based on: https://github.com/gf3/dotfiles/blob/db235ad2/.config/fish/functions/gh.fish
function github --description 'Open the current repo in GitHub'
  set -l url_base 'github.com'

  set -l git_status (git status --branch --porcelain=v2)
  or return
  set -l branch (string match -r '(?<=branch.head ).*' $git_status)
  set -l repo (git remote show -n origin | string replace -rf ".*Fetch URL:.*?(\w+/[\w-]+)\.git" '$1')

  set -l url "$url_base/$repo"

  if set -q argv[1]
    set -l file
    pushd (dirname $argv[1]); or return
      set -l git_dir (git rev-parse --show-toplevel)
      set -l relative_pwd (realpath $PWD | string replace "$git_dir" "")

      set file $relative_pwd/(basename $argv[1])
      set file (string replace -r ':(\d+)$' '#L$1' "$file")

      set url (string replace -a "//" "/" "$url/blob/$branch/$file")
    popd
  else
    set url "$url/tree/$branch"
  end

  echo "https://$url"
end
