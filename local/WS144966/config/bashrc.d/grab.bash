grab()
{   # grab a file from the server
    local remote_host='minerva'
    local remote_home='/Users/zozo'

    if [[ $# -eq 0 ]]; then
        scold "Usage: ${FUNCNAME} FILE [FILE ...]"
        scold "Paths with no leading slash are relative to ${remote_home}"
        return 64
    fi

    local remote_file
    for remote_file in "$@"; do
        case $remote_file in
            /*)
                remote_file="${remote_file}"
                ;;
            *)
                remote_file="${remote_home}/${remote_file}"
                ;;
        esac

        command scp -Cpr ${remote_host}:"${remote_file}" .
    done
}
