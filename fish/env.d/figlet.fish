set -l fontdirs $HOMEBREW_PREFIX/share/figlet/fonts
set -a fontdirs $XDG_DATA_HOME/figlet
set -a fontdirs /usr/share/figlet

for dir in $fontdirs
    if path is -d $dir
        set -gx FIGLET_FONTDIR $dir
        break
    end
end
