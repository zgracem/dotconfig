lspath()
{   # list path entries of $PATH or environment variable $1
    local var="${1-PATH}"
    tr ":" "\n" <<< "${!var}"
}
