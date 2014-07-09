# -----------------------------------------------------------------------------
# ~zozo/.config/bash/colours
# say hello: printf "zozo\x40inescapable\x2eorg"
# -----------------------------------------------------------------------------

# get the terminal colour depth (based on $TERM, not perfect but it'll do)
: ${colourdepth:=$(tput colors 2>/dev/null)}

# skip this file if the terminal can't support at least eight colours
if [[ $colourdepth -lt 8 ]]; then
    return
fi

export colourdepth

# -----------------------------------------------------------------------------
# basic colours
# -----------------------------------------------------------------------------

colours=(null black red green yellow blue magenta cyan white)
colours+=(bgblack bgred bggreen bgyellow bgblue bgmagenta bgcyan bgwhite)

   null='0'
   bold='1;'; ul='4;'; blink='5;'; inv='7;'
  black='30'; bgblack='40'
    red='31'; bgred='41'
  green='32'; bggreen='42'
 yellow='33'; bgyellow='43'
   blue='34'; bgblue='44'
magenta='35'; bgmagenta='45'
   cyan='36'; bgcyan='46'
  white='37'; bgwhite='47'

if [[ $colourdepth -ge 16 ]]; then
   colours+=(brblack brred brgreen bryellow brblue brmagenta brcyan brwhite)
    brblack="${bold}${black}"
      brred="${bold}${red}"
    brgreen="${bold}${green}"
   bryellow="${bold}${yellow}"
     brblue="${bold}${blue}"
  brmagenta="${bold}${magenta}"
     brcyan="${bold}${cyan}"
    brwhite="${bold}${white}"
fi

# -----------------------------------------------------------------------------
# semantic colours
# -----------------------------------------------------------------------------

colours+=(colour_reset colour_true colour_false colour_user colour_hi colour_2d)

colour_reset="${null}"

colour_true="${green}"
colour_false="${red}"
colour_hi="${white}"        # highlight colour
colour_2d="${green}"        # secondary colour

colour_user="${brblue}"     # see prompt.bash

# Prompt (iPhone SSH app) -- TERM_PROGRAM set in bashrc.bash
if [[ $TERM_PROGRAM == Prompt ]]; then
    colour_2d="${blue}"
    colour_hi="${brwhite}"
    colour_user="${cyan}"
fi

# -----------------------------------------------------------------------------
# solarized -- http://ethanschoonover.com/solarized
# -----------------------------------------------------------------------------

export solarized

if [[ $ITERM_PROFILE =~ light ]]; then
    solarized=light
elif [[ $ITERM_PROFILE =~ ^Default ]]; then
    solarized=dark
fi

bgflip()
{
    case $solarized in
        dark)   solarized=light ;;
        light)  solarized=dark  ;;
        *)      solarized=dark ;;
    esac

    echo "solarized=${solarized}"

    rl colours prompt
}

if [[ -n $solarized ]]; then
  colours+=(base03 base02 base01 base00 base0 base1 base2 base3 orange violet colour_bg)
    base03="${brblack}"
    base02="${black}"
    base01="${brgreen}"
    base00="${bryellow}"
     base0="${brblue}"
     base1="${brcyan}"
     base2="${white}"
     base3="${brwhite}"
    orange="${brred}"
    violet="${brmagenta}"

    colour_user="${blue}"

    case $solarized in
        dark)
            colour_bg="${bgblack}"
            colour_hi="${base2}"
            colour_2d="${base01}"
            ;;
        light)
            colour_bg="${bgwhite}"
            colour_hi="${base02}"
            colour_2d="${base1}"

            colour_true="${cyan}"
            colour_false="${orange}"
            ;;
    esac
fi

# ------------------------------------------------------------------------------
# add escape codes
# ------------------------------------------------------------------------------

export colours ${colours[@]}

# ($green -> $esc_green, $colour_true -> $esc_true)
for index in ${colours[@]}; do
    eval "esc_${index#*_}=\"[${!index}m\""
    unset index
done

export ${!esc_*}

# -----------------------------------------------------------------------------
# print a red "^C" when a command is aborted
# (.inputrc should have "set echo-control-characters off")
# -----------------------------------------------------------------------------

trap 'echo -ne "${esc_false}^C${esc_null}"' INT

# -----------------------------------------------------------------------------
# grep
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
GREP_COLORS+="se=${colour_hi}"    # separators

# deprecated
export GREP_COLOR="${ul}${orange}"

# -----------------------------------------------------------------------------
# ls
# -----------------------------------------------------------------------------

colour_dir="$HOME/share/dircolors"

if [[ -d $colour_dir ]] && _inPath dircolors; then
    if [[ -n $solarized ]]; then
        colour_file="$colour_dir/solarized.$solarized"
    else
        colour_file="$colour_dir/default"
    fi

    # sets and exports $LS_COLORS
    eval $(dircolors -b $colour_file)
fi

unset colour_{dir,file}

if ! _isGNU ls; then
    # http://geoff.greer.fm/lscolors/
    export LSCOLORS="exfxdacabxgagaabadHbHd"
    export CLICOLOR=1
fi

# -----------------------------------------------------------------------------
# shell history
# -----------------------------------------------------------------------------

HISTTIMEFORMAT="${esc_2d}${HISTTIMEFORMAT}${esc_null}"

# -----------------------------------------------------------------------------
# man pages in less
# -----------------------------------------------------------------------------

LESS_TERMCAP_mb="${esc_magenta}"      # begin blinking mode
LESS_TERMCAP_md="${esc_green}"        # begin bold mode [headers]
LESS_TERMCAP_me="${esc_null}"         # end blink/bold mode
LESS_TERMCAP_us="${esc_yellow}"       # begin underline [variables]
LESS_TERMCAP_ue="${esc_null}"         # end underline
LESS_TERMCAP_so="${esc_orange}"       # begin standout [info box]
LESS_TERMCAP_se="${esc_null}"         # end standout
LESS_TERMEND="${esc_null}"            # reset colours

export ${!LESS_TERM*}

# ------------------------------------------------------------------------------
# GNU screen
# ------------------------------------------------------------------------------

if [[ $solarized == light ]]; then
    SCREENRC="$dir_config/screenrc.light"
fi

# -----------------------------------------------------------------------------
# gcc
# -----------------------------------------------------------------------------

export GCC_COLORS=1
