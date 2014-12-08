# -----------------------------------------------------------------------------
# ~zozo/.config/bash/colour.bash
# -----------------------------------------------------------------------------

# get the terminal colour depth (based on $TERM, not perfect but it'll do)
if [[ -z $colourdepth ]]; then
    export colourdepth="$(tput colors 2>/dev/null)"
fi

# skip this file if the terminal can't support at least eight colours
if (( colourdepth < 8 )); then
    return
fi

# -----------------------------------------------------------------------------
# basic colours
# -----------------------------------------------------------------------------

# reset
unset -v ${colours[*]} colours ${props[*]} props

# properties
   null='0'
   bold='1;'; ul='4;'; blink='5;'; inv='7;'

props=(null bold ul blink inv)

# basic ANSI colours
  black='30'; bgblack='40'
    red='31'; bgred='41'
  green='32'; bggreen='42'
 yellow='33'; bgyellow='43'
   blue='34'; bgblue='44'
magenta='35'; bgmagenta='45'
   cyan='36'; bgcyan='46'
  white='37'; bgwhite='47'

colours=(null black red green yellow blue magenta cyan white)
colours+=(bgblack bgred bggreen bgyellow bgblue bgmagenta bgcyan bgwhite)

# bright ANSI colours
if [[ $colourdepth -ge 16 ]]; then
    brblack="${bold}${black}"
      brred="${bold}${red}"
    brgreen="${bold}${green}"
   bryellow="${bold}${yellow}"
     brblue="${bold}${blue}"
  brmagenta="${bold}${magenta}"
     brcyan="${bold}${cyan}"
    brwhite="${bold}${white}"

    colours+=(brblack brred brgreen bryellow brblue brmagenta brcyan brwhite)
fi

# -----------------------------------------------------------------------------
# semantic colours
# -----------------------------------------------------------------------------

colour_reset="${null}"

colour_true="${green}"
colour_false="${red}"

colour_hi="${white}"        # highlight colour
colour_2d="${green}"        # secondary colour
colour_user="${brblue}"     # used in PS1 -- see prompt.bash

# Prompt (iPhone SSH app -- https://panic.com/prompt/)
if [[ $TERM_PROGRAM == Prompt ]]; then
    colour_hi="${brwhite}"
    colour_2d="${blue}"
    colour_user="${cyan}"
fi

colours+=(colour_reset colour_true colour_false colour_hi colour_2d colour_user)

# -----------------------------------------------------------------------------
# solarized -- http://ethanschoonover.com/solarized
# -----------------------------------------------------------------------------

# if the terminal hasn't already set this...
: ${solarized:=dark}

if [[ $ITERM_PROFILE =~ light ]]; then
    solarized=light
elif [[ $ITERM_PROFILE =~ ^Default ]]; then
    solarized=dark
fi

if [[ -n $solarized ]]; then
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

    colours+=(base03 base02 base01 base00 base0 base1 base2 base3 orange violet)

    colour_user="${blue}"

    # re/define semantic colours
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

    colours+=(colour_bg)
fi

export solarized

# ------------------------------------------------------------------------------
# add escape codes
# ------------------------------------------------------------------------------

add_escape_codes()
{   # $green -> $esc_green, $colour_true -> $esc_true

    local -a indexes=("$@")
    local index

    for index in "${indexes[@]}"; do
        local var_name="esc_${index#*_}"

        if [[ -n ${!index} && -z ${!var_name} ]]; then
            eval "${var_name}=\"[${!index}m\""
        fi
    done
}

add_escape_codes ${colours[*]}
unset -f add_escape_codes

# -----------------------------------------------------------------------------
# miscellany
# -----------------------------------------------------------------------------

# print a red "^C" when a command is aborted
trap 'echo -ne "${esc_false}^C${esc_null}"' INT

# disable echoing of control characters
(hash stty && stty -ctlecho) &>/dev/null

# enable colourized output for gcc
export GCC_COLORS=1

# export everything
export colours ${colours[*]} ${!colour_*} ${!esc_*}
