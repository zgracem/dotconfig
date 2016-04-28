return
## ZGM 2015-10-28 -- I actually kinda like the longer hostname

# trim hostname for aesthetics
export HOSTNAME=${HOSTNAME%%.*}

. "${dir_config}/bash/functions.d/title.bash"
. "${dir_config}/bash/bashrc.d/prompt.bash"
