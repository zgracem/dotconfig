# -----------------------------------------------------------------------------
# ~zozo/.config/bash/colours
# say hello: printf "zozo\x40inescapable\x2eorg"
# -----------------------------------------------------------------------------
# solarized -- http://ethanschoonover.com/solarized
# -----------------------------------------------------------------------------

# should be set by terminal emulator
: ${solarizedBG:="dark"}

if [[ $ITERM_PROFILE =~ light ]]; then
    solarizedBG=light
fi

# basic setup
colours="base03 base02 base01 base00 base0 base1 base2 base3 "
colours+="red orange green yellow blue magenta violet cyan null "

 base03="1;30"
 base02="0;30"
 base01="1;32"
 base00="1;33"
  base0="1;34"
  base1="1;36"
  base2="0;37"
  base3="1;37"
    red="0;31"
 orange="1;31"
  green="0;32"
 yellow="0;33"
   blue="0;34"
magenta="0;35"
 violet="1;35"
   cyan="0;36"
   null="0"

# set preferred colour values
colours+="colour_true colour_false colour_hi colour_2d colour_user colour_reset"

colour_reset="${null}"

colour_true="${green}"
colour_false="${red}"

colour_hi="${base2}"      # highlight colour
colour_2d="${base01}"     # secondary colour

colour_user="${blue}"     # see prompt.bash

[[ $solarizedBG == light ]] && {
    colour_true="${cyan}"
    colour_false="${orange}"

    colour_hi="${base02}"     
    colour_2d="${base0}"      
}

# Prompt (iPhone SSH app)
[[ $COLUMNS -eq 71 && $LINES -le 26 ]] && {
    colour_2d="${blue}"
    colour_hi="${base3}"   # bright white
    colour_user="${cyan}"
}

export $colours

# -----------------------------------------------------------------------------
# grep
# -----------------------------------------------------------------------------

export GREP_COLORS=

GREP_COLORS+="sl=${null}:"     # whole selected lines
GREP_COLORS+="cx=${null}:"     # whole context lines
GREP_COLORS+="mt=${orange}:"   # matching text
GREP_COLORS+="ms=${orange}:"   # matching text in a selected line
GREP_COLORS+="mc=${orange}:"   # matching text in a context line
GREP_COLORS+="fn=${blue}:"     # filenames
GREP_COLORS+="ln=${green}:"    # line numbers
GREP_COLORS+="bn=${yellow}:"   # byte offsets
GREP_COLORS+="se=${colour_hi}" # separators

# deprecated
export GREP_COLOR="${orange}"

# ------------------------------------------------------------------------------
# add escape codes
# ------------------------------------------------------------------------------

for index in $colours; do
    eval "$index=\"[${!index}m\""
    unset index
done

# -----------------------------------------------------------------------------
# man pages in less
# -----------------------------------------------------------------------------

LESS_TERMCAP_mb="${magenta}"  # begin blinking mode
LESS_TERMCAP_md="${green}"    # begin bold mode [headers]
LESS_TERMCAP_me="${null}"     # end blink/bold mode
LESS_TERMCAP_us="${yellow}"   # begin underline [variables]
LESS_TERMCAP_ue="${null}"     # end underline
LESS_TERMCAP_so="${orange}"   # begin standout [info box]
LESS_TERMCAP_se="${null}"     # end standout

export ${!LESS_TERMCAP_*}

# -----------------------------------------------------------------------------
# ls
# -----------------------------------------------------------------------------

dir_colours="$HOME/.dir_colors"

if _inPath dircolors && [[ -d $dir_colours ]]; then
    case $solarizedBG in
        light|dark)
            colourFile="$dir_colours/solarized.$solarizedBG"
            ;;
        *)
            colourFile="$dir_colours/default"
            ;;
    esac

    eval $(dircolors -b $colourFile)
else
    # http://geoff.greer.fm/lscolors/
    export CLICOLOR=1
    export LSCOLORS="exfxdeedbxaeGeabadhchd"
fi

unset colour{Dir,File}

# ------------------------------------------------------------------------------
# GNU screen
# ------------------------------------------------------------------------------

[[ $solarizedBG == light ]] && {
    SCREENRC="$dir_config/screenrc.light"
}
