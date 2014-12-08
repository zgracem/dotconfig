# wget
# http://www.gnu.org/software/wget/

_inPath wget || return

# -----------------------------------------------------------------------------
# aliases
# -----------------------------------------------------------------------------

alias dl='wget -c'                  # download a file
alias headers='wget --spider -Snv'  # get HTTP headers
alias myip='wget -qO - $ip_site'    # external IP address (see private.bash)
