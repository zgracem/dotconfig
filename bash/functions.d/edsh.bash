edsh()
{   # edit a script

    local dir
    for dir in "$dir_scripts" "$dir_scripts/dev"; do
        local script="$dir/${1%.sh}.sh"

        if [[ -f $script ]]; then
            _edit "$script"
            return 0
        fi
    done

    return 1
}
