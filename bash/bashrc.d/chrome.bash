# Google Chrome

flags_chrome='--allow-file-access '
flags_chrome+='--allow-file-access-from-files '

if [[ -n $SOCKS5_SERVER ]]; then
    flags_chrome+="--proxy-server='socks5://${SOCKS5_SERVER}' "
fi

chrome()
{
    case $OSTYPE in
        darwin*)
            open -a "Google Chrome" --args $flags_chrome "$@"
            ;;
        cygwin)
            "${dir_scripts}/chrome.sh" "$@"
            # TODO: rewrite script to use $flags_chrome
            ;;
        *)
            return 1
            ;;
    esac
}
