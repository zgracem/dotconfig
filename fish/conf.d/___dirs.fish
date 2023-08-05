# XDG base directories
# * https://specifications.freedesktop.org/basedir-spec/latest/ar01s02.html
# * https://wiki.archlinux.org/index.php/XDG_Base_Directory

set -q XDG_CONFIG_HOME[1]; or set -gx XDG_CONFIG_HOME ~/.config
set -q XDG_DATA_HOME[1]; or set -gx XDG_DATA_HOME ~/.local/share
set -q XDG_CACHE_HOME[1]; or set -gx XDG_CACHE_HOME ~/var/cache
set -q XDG_RUNTIME_DIR[1]; or set -gx XDG_RUNTIME_DIR ~/var/run
set -q XDG_STATE_HOME[1]; or set -gx XDG_STATE_HOME ~/var/lib

if string match -q "$HOME*" $XDG_RUNTIME_DIR
    mkdir -p -v $XDG_RUNTIME_DIR
    and chown $USER $XDG_RUNTIME_DIR
    and chmod 0700 $XDG_RUNTIME_DIR
end

# XDG user directories
# * https://www.freedesktop.org/wiki/Software/xdg-user-dirs/
# * https://wiki.archlinux.org/index.php/XDG_user_directories

# read defaults from ~/.config/user-dirs.dirs
if path is -f $XDG_CONFIG_HOME/user-dirs.dirs
    set -l pattern '^(?<var>[[:upper:]]+)="?(?<dir>.+)"?$'
    while read line
        string match -rq $pattern "$line"; and eval "set -gx XDG_"$var"_DIR $dir"
    end <$XDG_CONFIG_HOME/user-dirs.dirs
end

# Cygwin/MSYS
if uname -s | string match -q '*_NT-*'
    set user_profile
    if set -q USERPROFILE
        set user_profile (cygpath -au $USERPROFILE)
    else
        switch (uname -s)
            case 'CYGWIN*'
                set user_profile /cygdrive/c/Users/$USER
            case 'MSYS*'
                set user_profile /c/Users/$USER
        end
        set -gx USERPROFILE (cygpath -aw $user_profile)
    end

    set -gx XDG_DESKTOP_DIR "$user_profile/Desktop"
    set -gx XDG_DOCUMENTS_DIR "$user_profile/My Documents"
    set -gx XDG_DOWNLOAD_DIR "$user_profile/Downloads"
    set -gx XDG_MUSIC_DIR "$user_profile/Music"
    set -gx XDG_PUBLICSHARE_DIR (cygpath -au "$PUBLIC")
    set -gx XDG_VIDEOS_DIR "$user_profile/Videos"

    switch $hostname
        case 'WS*'
            set -gx XDG_DOCUMENTS_DIR (cygpath -au "$HOMESHARE\\My Documents")
            set -gx XDG_DOWNLOAD_DIR ~/tmp
            set -gx XDG_MUSIC_DIR "$XDG_DOCUMENTS_DIR/My Music"
            set -gx XDG_PICTURES_DIR "$XDG_DOCUMENTS_DIR/My Pictures"
            set -gx XDG_VIDEOS_DIR "$XDG_DOCUMENTS_DIR/My Videos"
    end
end

# Linux
if uname -s | string match -q Linux
    set -gx XDG_DESKTOP_DIR ~/.desktop
    set -gx XDG_DOCUMENTS_DIR ~/doc
    set -gx XDG_DOWNLOAD_DIR ~/tmp

    for dirvar in (set --names | string match -er '^XDG_')
        path is -d $$dirvar; or set --erase $dirvar
    end
end
