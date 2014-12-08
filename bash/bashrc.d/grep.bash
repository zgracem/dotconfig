# -----------------------------------------------------------------------------
# flags
# -----------------------------------------------------------------------------

export flags_grep=
flags_grep+='--extended-regexp '  # use ERE syntax (-E)
flags_grep+='--colour=auto '      # display results in colour
flags_grep+='--no-messages '      # no errors about missing/unreadable files (-s)
flags_grep+='--directories=skip ' # silently skip directories by default (-d)
flags_grep+='--exclude-dir=.git'  # skip .git directories

grep()
{
    command grep $flags_grep "$@"
}

export -f grep

# -----------------------------------------------------------------------------
# colours
# -----------------------------------------------------------------------------

export GREP_COLORS=

GREP_COLORS+="sl=${null}:"        # whole selected lines
GREP_COLORS+="cx=${colour_2d}:"   # whole context lines
GREP_COLORS+="mt=${orange}:"      # any matching text
GREP_COLORS+="ms=${ul}${orange}:" # matching text in a selected line
GREP_COLORS+="mc=${orange}:"      # matching text in a context line
GREP_COLORS+="fn=${colour_2d}:"   # filenames
GREP_COLORS+="ln=${blue}:"        # line numbers
GREP_COLORS+="bn=${cyan}:"        # byte offsets
GREP_COLORS+="se=${null}"         # separators

# deprecated
export GREP_COLOR="${ul}${orange}"
