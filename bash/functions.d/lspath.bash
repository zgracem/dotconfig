lspath()
{   # list path entries of $PATH or environment variable $1
    declare listPath="${1-PATH}"

    echo ${!listPath} \
    | tr : '\n'
}
