_inPath diskutil || return

# >> https://github.com/ptone/diskutil_completion
file="$HOME/opt/etc/bash_completion.d/diskutil_completion"

if [[ -f $file ]]; then
  . "$file"
fi

unset -v file
