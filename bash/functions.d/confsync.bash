# TODO: add ~/lib/zkit syncing

confsync()
{
    local dir_config="$HOME/Dropbox/.config"
    local dir_scripts="$HOME/Dropbox/scripts"

    if [[ ${FUNCNAME[1]} == main ]]; then
        scold "this function cannot be called directly"
        return 1
    elif [[ -n $dest && -n $config_filters && -n $script_filters && -d $dir_config && -d $dir_scripts ]]; then
        syncdir "$dir_config"  "$dest/${dir_config##*/}"  "${config_filters[@]}"
        syncdir "$dir_scripts" "$dest/${dir_scripts##*/}" "${script_filters[@]}"
    else
        scold "something went wrong :("
        return 1
    fi
}

hconfsync()
{
    local dest="Hiroko:/Users/zozo"

    local -a config_filters=(
        --exclude=.DS_Store
        --exclude=.git/
        --exclude=alpine/ 
        --exclude=direnv/
        --exclude=fish/ 
        --exclude=keybase/
        --include=local/Hiroko/
        --exclude='local/*'
        --exclude='local/*/history'
        --exclude='transmission*/'
        --exclude=jrnl
        --exclude=trc
        --exclude=youtube-dl.conf
    )

    local -a script_filters=(
        --include=brew-check.sh
        --include=brew-relink.sh
        --include=brew-tidy.sh
        --include=brew-vars.sh
        --include=btadd.sh
        --include=countdown.sh
        --include=fds.sh
        --include=fixchmod.sh
        --include=hardware.rb
        --include=loginbanner.sh
        --include=manpdf.sh
        --include=matins.sh
        --include=newpassword.sh
        --include=os.sh
        --include=pinback.sh
        --include=tc.sh
        --include=tinypng.sh
        --include=trash.sh
        --include=weather.sh
        --exclude='*'
    )

    confsync
}

wfconfsync()
{
    local dest="WebFaction:/home/zozo"

    local -a config_filters=(
        --exclude=.DS_Store
        --exclude=alpine/
        --exclude=brew/
        --exclude=fish/
        --exclude=gnupg/
        --exclude=keybase/
        --include=local/web500/
        --exclude='local/*'
        --exclude='local/*/history'
        --exclude=misc/
        --exclude=skel/
        --exclude='.git*'
        --exclude='transmission*/'
        --exclude=jrnl
        --exclude=trc
        --exclude=youtube-dl.conf
    )

    local -a script_filters=(
        --include=countdown.sh
        --include=fds.sh
        --include=fixchmod.sh
        --include=loginbanner.sh
        --include=matins.sh
        --include=newpassword.sh
        --include=os.sh
        --include=tc.sh
        --include=tinypng.sh
        --include=trash.sh
        --include=weather.sh
        --exclude='*'
    )

    confsync
}
