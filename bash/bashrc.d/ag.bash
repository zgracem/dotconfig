# Silver Searcher
# https://github.com/ggreer/the_silver_searcher

_inPath ag || return

# -----------------------------------------------------------------------------
# flags
# -----------------------------------------------------------------------------

ag()
{
    local flags_ag=
    flags_ag+='--path-to-agignore "${dir_config}/agignore" '
    flags_ag+='--skip-vcs-ignores '
    flags_ag+='--color-line-number "0;34" '
    flags_ag+='--color-match "4;1;31" '
    flags_ag+='--color-path "1;32" '
    flags_ag+='--noheading '
    flags_ag+='--smart-case '

    command ag $flags_ag "$@"
}
