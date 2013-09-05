# -----------------------------------------------------------------------------
# ~zozo/.config/bash/places
# say hello: printf "zozo\x40inescapable\x2eorg"
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# variables
# -----------------------------------------------------------------------------

# universal
dir_config="$HOME/.config"
dir_local="$HOME/.local"

dir_dropbox="$HOME/Dropbox"
dir_poems="$dir_dropbox/Writing/p"
dir_proj="$dir_dropbox/Projects"

dir_mybin="$HOME/bin"
dir_mytmp="$HOME/tmp"
dir_notes="$HOME/txt"
dir_scripts="$HOME/scripts"
dir_dev="$dir_scripts/_dev"

# platform-specific
case $OSTYPE in
    darwin*)
        dir_apps="/Applications"
        dir_desktop="$HOME/Desktop"
        dir_docs="$HOME/Documents"
        dir_downloads="$HOME/Downloads"
        dir_music="$HOME/Music/iTunes/iTunes Media/Music"
        dir_prefs="$HOME/Library/Preferences"
        dir_drive="/Volumes/RED"
        ;;

    cygwin)
        dir_desktop="$(cygpath --desktop)"
        dir_docs="$(cygpath --mydocs)"
        dir_downloads="$dir_docs/Downloads"
        dir_dropbox="$dir_docs/Dropbox"
        dir_winHome="$(cygpath -au "$USERPROFILE")"
        ;;
esac

# machine-specific
case $HOSTNAME in
    Minerva)
        dir_oldRoot="/Volumes/Minerva HD"
        dir_oldHome="$dir_oldRoot$HOME"
        dir_oldMusic="$dir_oldHome/Music/iTunes/iTunes Music/Music"
        ;;

    Erato)
        dir_docs="$dir_dropbox/Documents"
        ;;

    ws144966)
        dir_apps="$dir_winHome/Applications"
        dir_downloads="$HOME/tmp"
        dir_dropbox="$HOME/Dropbox"
        ;;

    WTL2)
        dir_music="$dir_docs/My Music/iTunes/iTunes Media/Music"
        ;;
esac

export ${!dir_*}

# -----------------------------------------------------------------------------
# aliases
# -----------------------------------------------------------------------------

# alias --  -="cd -"      # just type "-"
alias    ..='cd ..'
alias   ...='cd ../..'
alias  ....='cd ../../..'
alias .....='cd ../../../..'

dirAlias()
{
    declare name="$1" value="$2"

    [[ -d $value ]] && {
        alias "$name"="cd \"$value\""
    }
}

dirAlias apps     "$dir_apps"
dirAlias bin      "$dir_mybin"
dirAlias conf     "$dir_config"
dirAlias .bash    "$dir_config/bash"
dirAlias dbox     "$dir_dropbox"
dirAlias ddocs    "$dir_dropbox/Documents"
dirAlias desk     "$dir_desktop"
dirAlias dev      "$dir_dev"
dirAlias dls      "$dir_downloads"
dirAlias docs     "$dir_docs"
dirAlias music    "$dir_music"
dirAlias notes    "$dir_notes"
dirAlias oldroot  "$dir_oldRoot"
dirAlias oldhome  "$dir_oldHome"
dirAlias oldmusic "$dir_oldMusic"
dirAlias poems    "$dir_poems"
dirAlias prefs    "$dir_prefs"
dirAlias proj     "$dir_proj"
dirAlias scr      "$dir_scripts"
dirAlias tmp      "$dir_mytmp"
dirAlias txt      "$dir_notes"
dirAlias winhome  "$dir_winHome"
