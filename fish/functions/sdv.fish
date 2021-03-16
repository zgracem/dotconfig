function sdv -d 'Stardew Valley'
    set -l dir "$HOME/Library/Application Support/Steam/SteamApps/common/Stardew Valley"
    env TERM=xterm $dir/Contents/MacOS/StardewModdingAPI.bin.osx
end
