lspath()
{   # list path entries of $PATH or environment variable $1
    local listPath="${1-PATH}"

    tr : '\n' <<< "${!listPath}"
}
