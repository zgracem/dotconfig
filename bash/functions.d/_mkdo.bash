mkcd()
{   # create a directory then move into it
    command mkdir -p "$1" \
        && cd "$1"
}

mkcp()
{ # create a directory then copy files into it
  # Usage: mkmv FILE [FILES ...] DIR

  command mkdir -p -- "${@: -1}" \
      && cp -v -- "$@"
}

mkmv()
{ # create a directory then move files into it
	# Based on: https://github.com/tejr/dotfiles/blob/master/bash/bashrc.d/mkmv.bash
  # Usage: mkmv FILE [FILES ...] DIR

  command mkdir -p -- "${@: -1}" \
      && mv -v -- "$@"
}
