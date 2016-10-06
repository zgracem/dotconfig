# -----------------------------------------------------------------------------
# flags
# -----------------------------------------------------------------------------

quietly unalias grep

grep()
{
    command grep -EsId skip --colour=auto --exclude-dir=.git "$@"
    #             ││││      │             └─ skip .git directories
    #             ││││      └─────────────── display results in colour
    #             │││└────────────────────── silently skip directories by default
    #             ││└─────────────────────── ignore binary files
    #             │└──────────────────────── no errors about missing/unreadable files
    #             └───────────────────────── use ERE syntax
}

# -----------------------------------------------------------------------------
# function wrappers
# -----------------------------------------------------------------------------

g()
{   # search files in the current directory

    local opts='n'
    #           └─ output line numbers

    grep -$opts "$@" *
}

gg()
{   # search files and directories in the current directory

    local opts='R'
    #           └─ recursive

    g -$opts "$@"
}
