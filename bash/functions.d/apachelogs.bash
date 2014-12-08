[[ -d /var/log/apache2 ]] || return

apachelogs()
{
    declare logType

    if [[ $STY || $TMUX ]]; then
        for logType in access error; do
            newwin --title ${logType}_log \
            	tail -f /var/log/apache2/${logType}_log
        done
    fi
}
