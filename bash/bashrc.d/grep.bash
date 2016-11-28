# -----------------------------------------------------------------------------
# flags
# -----------------------------------------------------------------------------

unalias grep 2>/dev/null

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
  grep --line-number "$@" *
}

gg()
{   # search files and directories in the current directory
  g -R "$@"
  #  └─ recursive
}
