_inPath sift || return

unset -f g gg

gg()
{   # search files and directories in the current directory

    local opts='in --color'
    #           ││ └── 'auto' doesn't work on Cygwin (2015-10-19)
    #           │└──── output line numbers
    #           └───── case-insensitive matching

    sift -$opts "$@" *
}

g()
{   # search files in the current directory
    local opts='R'
    #           └─ disable recursion (on by default)

    gg -$opts "$@" *
}
