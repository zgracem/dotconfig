mkmv()
{   # create a directory then move files into it
	# Usage: mkmv FILE [FILES ...] DIR

    local newdir="$1"; shift
    local -a files=("$@")

    command mkdir -p -- "${@: -1}" \
        && mv -v -- "$@"
}
