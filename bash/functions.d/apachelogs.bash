[[ -d /var/log/apache2 ]] || return

apachelogs()
{
    if _mux; then
	    local log_type
        for log_type in access error; do
            newwin --title ${log_type}_log \
            	tail -f /var/log/apache2/${log_type}_log
        done
    fi
}
