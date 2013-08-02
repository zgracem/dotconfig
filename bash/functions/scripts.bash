# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/scripts.bash
# for editing and processing shell scripts
# ------------------------------------------------------------------------------

newsh()
{   # create a new shell script
    declare name="${1%.sh}"
    declare script="$dir_dev/$name.sh"

    [[ ! -f $script ]] && {
        command cp "$dir_dev/.new.sh" "$script" &>/dev/null
        command chmod 700 "$script"
        command vim -Es \
            -c "%s/\(^# Name[[:space:]]*:\).*$/\1 $name/" \
            -c "%s/\(^# Date[[:space:]]*:\).*$/\1 $(date +%F)/" \
            -c "%s/\(^# URL[[:space:]]*:\) \(http.*\)$/\1 \2$name.sh/" \
            -c x \
            "$script"
    }

    _edit "$script"
}

edsh()
{   # edit a script
    declare checkDir script
    
    for checkDir in $dir_scripts/**; do
        script="$checkDir/${1%.sh}.sh"
        if [[ -f $script ]]; then
            _edit "$script"
        fi
    done
    return 1
}
