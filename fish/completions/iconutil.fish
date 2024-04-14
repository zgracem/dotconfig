set -l iconutil_convert_modes '
    iconset\tConvert\ .icns\ to\ .iconset
    icns\tConvert\ .iconset\ to\ icns
'

complete -c iconutil -s c -l convert -xa "$iconutil_convert_modes" -d "Convert mode"
complete -c iconutil -s o -l output -rF -d "Output file name"
