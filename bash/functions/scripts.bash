# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/scripts.bash
# for editing and processing shell scripts
# ------------------------------------------------------------------------------

newsh()
{   # create a new shell script
    declare name="${1:-myscript_$(date +%y%m%d)}"
    declare script="$dir_dev/${name%.sh}.sh"

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

    for checkDir in $dir_scripts{,/dev}; do
        script="$checkDir/${1%.sh}.sh"
        if [[ -f $script ]]; then
            _edit "$script"
        fi
    done
    return 1
}

draft()
{   # save a draft
    declare scriptName="${1%.sh}" draftDir="$dir_dev/drafts"
    declare script="$dir_scripts/$scriptName.sh"
    declare draft lmSeconds lmDate i=2

    [[ -f $script ]] || {
        scold $FUNCNAME "$scriptName: not found"
        return 1
    }

    lmSeconds=$(lm $script)
    lmDate=$(parseEpoch $lmSeconds "%y%m%d")
    draft="${draftDir}/${scriptName}.${lmDate}.sh"

    while [[ -f $draft ]]; do
        draft="${draft%.sh}"
        draft="${draft%_*}_${i}.sh"
        ((i++))
    done

    command cp -a "$script" "$draft"
    printf "'%s' -> '%s'\n" "${script/#$HOME/~}" "${draft/#$HOME/~}"
}
