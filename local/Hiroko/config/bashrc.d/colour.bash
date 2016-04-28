if [[ $TERM_PROGRAM_VERSION == 240.2 ]]; then
    # we're running in Terminal.app locally
    colour_user=$magenta

    z::colour::add_esc colour_user
    # . "$dir_config/bash/bashrc.d/prompt.bash"
fi
