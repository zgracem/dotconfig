_inPath diskutil || return

# >> https://github.com/ptone/diskutil_completion

f="$HOME/opt/etc/bash_completion.d/diskutil_completion"
# shellcheck disable=SC1090
[[ -f $f ]] && . "$f"
unset -v f
