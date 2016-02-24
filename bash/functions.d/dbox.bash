dbox()
{   # open the current (or specified) folder at dropbox.com
    
    if [[ -n $1 ]]; then
        local target=$1
    else
        local target=$PWD
    fi

    local thing; thing=$(readlink -e "$target") || return

    if [[ $thing =~ ^$dir_dropbox/(.+) ]]; then
        local db_path=${BASH_REMATCH[1]// /%20}
    else
        scold "Error: $target does not appear to be in Dropbox"
        return 1
    fi

    if [[ -d $thing ]]; then
        local url="https://www.dropbox.com/home/$db_path?d=1"
        # get parent directory instead
        # thing=${thing%/*}
    else
        local url="https://www.dropbox.com/revisions/$db_path?_subject_uid=$DROPBOX_UID"
    fi

    "$BROWSER" "$url" 
}
