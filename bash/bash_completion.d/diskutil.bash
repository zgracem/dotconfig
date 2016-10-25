_inPath diskutil || return

# >> https://github.com/ptone/diskutil_completion

f="$HOME/opt/etc/bash_completion.d/diskutil_completion"
[[ -f $f ]] && . "$f"
unset -v f
