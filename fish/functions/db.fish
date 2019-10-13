function db --description 'Open a file or directory at dropbox.com' -a target
  set -l url_base 'dropbox.com'
  set -l url "$url_base/home"
  set -l dropbox_dir $HOME/Dropbox

  set target (realpath $target 2>/dev/null || realpath $PWD)
  or return

  if not string match -q "$dropbox_dir*" $target
    echo >&2 "not in Dropbox: $target"
    return 1
  end

  set -l dir
  set -l base

  if test -d $target
    set dir (echo $target | string replace -r "^$dropbox_dir" "")
  else if test -f $target
    set dir (dirname $target | string replace -r "^$dropbox_dir" "")
    set base "?preview="(basename $target)
  else if not test -e $target
    echo >&2 "not a file or directory: $target"
    return 1
  end

  "$BROWSER" "https://$url$dir$base"
end
