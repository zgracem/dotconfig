draft()
{   # save a draft
    declare scriptName="${1%.sh}"
    declare script="$dir_scripts/$scriptName.sh"
    declare draftDir="$dir_dev/done/drafts"
    declare draft lmSeconds lmDate i=2

    if [[ ! -f $script ]]; then
        scold "$FUNCNAME: $script: not found"
        return 1
    elif ! _isGNU stat || ! _isGNU date; then
        scold "$FUNCNAME: GNU stat(1) and date(1) required"
        return 1
    fi

    lmSeconds=$(stat -c %Y $script)
    lmDate=$(date -u -d @$lmSeconds +"%y%m%d")
    draft="${draftDir}/${scriptName}.${lmDate}.sh"

    while [[ -f $draft ]]; do
        draft="${draft%.sh}"
        draft="${draft%_*}_${i}.sh"
        ((i++))
    done

    command cp -a "$script" "$draft"
    printf "'%s' -> '%s'\n" "${script/#$HOME/$'~'}" "${draft/#$HOME/$'~'}"
}
