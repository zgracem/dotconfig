# -----------------------------------------------------------------------------
# ~zozo/.config/bash/colours
# say hello: printf "zozo\x40inescapable\x2eorg"
# -----------------------------------------------------------------------------
# solarized -- http://ethanschoonover.com/solarized
# -----------------------------------------------------------------------------

# should be set by terminal emulator
: ${solarizedBG:="dark"}

[[ $ITERM_PROFILE =~ light ]] &&
    solarizedBG=light

bgflip()
{
    case $solarizedBG in
        dark)   solarizedBG=light ;;
        light)  solarizedBG=dark  ;;
        *)      return 1 ;;
    esac

    rl colours prompt
}

# -----------------------------------------------------------------------------
# setup
# -----------------------------------------------------------------------------

colours=(null black red green yellow blue magenta cyan white)

   null="0"
  black="30"
    red="31"
  green="32"
 yellow="33"
   blue="34"
magenta="35"
   cyan="36"
  white="37"

[[ $solarizedBG =~ dark|light ]] && {
  colours+=(base03 base02 base01 base00 base0 base1 base2 base3 orange violet)
    base03="1;${black}"
    base02="0;${black}"
    base01="1;${green}"
    base00="1;${yellow}"
     base0="1;${blue}"
     base1="1;${cyan}"
     base2="0;${white}"
     base3="1;${white}"
    orange="1;${red}"
    violet="1;${magenta}"
} || {
   colours+=(brblack brred brgreen bryellow brblue brmagenta brcyan brwhite)
    brblack="1;${black}"
      brred="1;${red}"
    brgreen="1;${green}"
   bryellow="1;${yellow}"
     brblue="1;${blue}"
  brmagenta="1;${magenta}"
     brcyan="1;${cyan}"
    brwhite="1;${white}"
}

# -----------------------------------------------------------------------------
# preferred colours
# -----------------------------------------------------------------------------

colours+=(colour_reset colour_true colour_false colour_user colour_hi colour_2d)

colour_reset="${null}"

colour_true="${green}"
colour_false="${red}"

colour_user="${blue}"             # see prompt.bash

case $solarizedBG in
    dark)
        colour_hi="${base2}"      # highlight colour
        colour_2d="${base01}"     # secondary colour
        ;;
    light)
        colour_hi="${base02}"
        colour_2d="${base0}"

        colour_true="${cyan}"
        colour_false="${orange}"
        ;;
    *)
        colour_hi="${brwhite}"
        colour_2d="${brblack}"
        colour_user="${brblue}"
        ;;
esac

# Prompt (iPhone SSH app)
[[ $COLUMNS -eq 71 && $LINES -le 26 ]] && {
    colour_2d="${blue}"
    colour_hi="${brwhite}"
    colour_user="${cyan}"
}

export colours ${colours[@]}

# -----------------------------------------------------------------------------
# grep
# -----------------------------------------------------------------------------

export GREP_COLORS=

GREP_COLORS+="sl=${null}:"     # whole selected lines
GREP_COLORS+="cx=${null}:"     # whole context lines
GREP_COLORS+="mt=${orange}:"   # matching text
GREP_COLORS+="ms=${orange}:"   # matching text in a selected line
GREP_COLORS+="mc=${orange}:"   # matching text in a context line
GREP_COLORS+="fn=${green}:"    # filenames
GREP_COLORS+="ln=${yellow}:"   # line numbers
GREP_COLORS+="bn=${cyan}:"     # byte offsets
GREP_COLORS+="se=${colour_hi}" # separators

# deprecated
export GREP_COLOR="${orange}"

# ------------------------------------------------------------------------------
# add escape codes
# ------------------------------------------------------------------------------

for index in ${colours[@]}; do
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

colourDir="$HOME/share/dircolors"

if _inPath dircolors && [[ -d $colourDir ]]; then
    case $solarizedBG in
        light|dark)
            colourFile="$colourDir/solarized.$solarizedBG"
            ;;
        *)
            colourFile="$colourDir/default"
            ;;
    esac

    # sets and exports $LS_COLORS
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
