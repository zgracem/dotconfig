_inPath diskutil || return

diskutil_file="$HOME/src/github/diskutil_completion/diskutil_completion"
diskutil_helper="${diskutil_file%/*}/complete_diskutil.py"
diskutil_link="$HOME/opt/bin/${diskutil_helper##*/}"

if [[ -f $diskutil_file && -f $diskutil_helper ]]; then
    if [[ ! -x $diskutil_helper ]]; then
        chmod 755 "$diskutil_helper"
    fi

    if [[ ! -L $diskutil_link ]]; then
        ln -sf "$diskutil_helper" "$diskutil_link"
    fi

    . "$diskutil_file"
fi

unset -v ${!diskutil_*}
