drive()
{
    if [[ ! -d $dir_drive ]]; then
        if ! dir_drive=$(findDrive $myDrive); then
            scold "'${myDrive}' not available"
            return 1
        fi
    fi

    builtin cd "$dir_drive" 2>/dev/null || {
        scold "'${myDrive}' not available"
        return 1
    }
}
