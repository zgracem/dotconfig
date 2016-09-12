# -----------------------------------------------------------------------------
# ~/.config/bash/colour.bash
# -----------------------------------------------------------------------------

# get the terminal colour depth (based on $TERM, not perfect but it'll do)
if [[ -z $TERM_COLOURDEPTH || -n $Z_RELOADING ]]; then
  TERM_COLOURDEPTH="$(tput -T ${PTERM:-$TERM} colors)" || return
fi

# skip this file if the terminal can't support at least eight colours
if (( TERM_COLOURDEPTH >= 8 )); then
  export TERM_COLOURDEPTH
else
  return
fi

# -----------------------------------------------------------------------------
# basic colours
# -----------------------------------------------------------------------------

# properties
reset=0; bold=1; italic=3; ul=4; blink=5; inv=7
props=(bold italic ul blink inv)
colours=()

# basic ANSI colours
black=30
red=31
green=32
yellow=33
blue=34
magenta=35
cyan=36
white=37

colours+=(black red green yellow blue magenta cyan white)

# bright colours
if (( TERM_COLOURDEPTH >= 16 )); then
  # Use aixterm codes to get actual *bright* colours instead of setting the
  # emulator to display bold text as unbold-but-bright. (Inspired by Prompt,
  # which doesn't offer that option.)
  brblack=90
  brred=91
  brgreen=92
  bryellow=93
  brblue=94
  brmagenta=95
  brcyan=96
  brwhite=97
else
  brblack=$black
  brred=$red
  brgreen=$green
  bryellow=$yellow
  brblue=$blue
  brmagenta=$magenta
  brcyan=$cyan
  brwhite=$white
fi

colours+=(brblack brred brgreen bryellow brblue brmagenta brcyan brwhite)

# -----------------------------------------------------------------------------
# semantic colours
# -----------------------------------------------------------------------------

colour_true=$green
colour_false=$red

colour_hi=$brwhite   # highlight colour
colour_dim=$brblack  # secondary colour

# used in PS1 -- see bashrc.d/prompt.bash
: ${colour_user:=$magenta}

colours+=(colour_true colour_false colour_hi colour_dim colour_user)
colours+=(reset)

# -----------------------------------------------------------------------------
# Solarized -- http://ethanschoonover.com/solarized
# -----------------------------------------------------------------------------

if [[ -n $Z_SOLARIZED ]]; then
  base03=$brblack
  base02=$black
  base01=$brgreen
  base00=$bryellow
   base0=$brblue
   base1=$brcyan
   base2=$white
   base3=$brwhite
  orange=$brred
  violet=$brmagenta

  colours+=(base03 base02 base01 base00 base0 base1 base2 base3 orange violet)

  # re/define semantic colours
  case $Z_SOLARIZED in
    dark)
      colour_hi=$base2
      colour_dim=$base01
      ;;
    light)
      colour_hi=$base02
      colour_dim=$base1

      colour_true=$cyan
      colour_false=$orange
      ;;
  esac

  export Z_SOLARIZED
fi

# ------------------------------------------------------------------------------
# add escape codes
# ------------------------------------------------------------------------------

_z_colour_add_esc()
{ # $green -> $esc_green, $colour_true -> $esc_true

  local -a indexes=("$@")
  local index

  for index in "${indexes[@]}"; do
    local var_name="esc_${index#*_}"

    if [[ -n ${!index} && -z ${!var_name} ]] || [[ $Z_RELOADING == "true" ]]; then
      # eval "$var_name=\"${CSI}${!index}m\""
      printf -v "$var_name" "${CSI}${!index}m"
    fi
  done
}

_z_colour_add_esc ${colours[*]} ${props[*]}

# # export everything
# export ${!esc_*}
### ZGM disabled 2016-06-17 -- what on earth uses this?

# -----------------------------------------------------------------------------
# grep
# -----------------------------------------------------------------------------

if (( TERM_COLOURDEPTH >= 16 )); then
  export GREP_COLORS=''

  GREP_COLORS+="sl=${reset}:"       # whole selected lines
  GREP_COLORS+="cx=${colour_dim}:"  # whole context lines
  GREP_COLORS+="mt=${brred}:"       # any matching text
  GREP_COLORS+="ms=${ul};${brred}:" # matching text in a selected line
  GREP_COLORS+="mc=${brred}:"       # matching text in a context line
  GREP_COLORS+="fn=${colour_dim}:"  # filenames
  GREP_COLORS+="ln=${blue}:"        # line numbers
  GREP_COLORS+="bn=${cyan}:"        # byte offsets
  GREP_COLORS+="se=${reset}"        # separators

  # deprecated
  export GREP_COLOR="${ul};${brred}"
fi

# -----------------------------------------------------------------------------
# ls
# -----------------------------------------------------------------------------

if ! _isGNU ls; then
  # Generated at http://geoff.greer.fm/lscolors/
  export LSCOLORS='exFxdacabxgagaabadHbHd'
  export CLICOLOR=1
fi

# -----------------------------------------------------------------------------
# miscellany
# -----------------------------------------------------------------------------

# colourize history output
if (( TERM_COLOURDEPTH >= 16 )); then
  HISTTIMEFORMAT="${esc_dim}${HISTTIMEFORMAT}${esc_reset}"
fi

# print a red "^C" when a command is aborted
if type -P stty >/dev/null; then
  # disable echoing of control characters
  stty -ctlecho >/dev/null
  bind 'set echo-control-characters off'

  # print a red "^C" on SIGINT
  trap 'printf "${esc_false}^C${esc_reset}"' INT
fi

# gcc diagnostics
export GCC_COLORS=""
GCC_COLORS+="error=${brred}:"
GCC_COLORS+="warning=${brmagenta}:"
GCC_COLORS+="note=${brcyan}:"
GCC_COLORS+="caret=${brgreen}:"
GCC_COLORS+="locus=${bryellow}:"
GCC_COLORS+="quote=${brblue}"

# 500 kV library for cool colour printing
export HV_BG="reset"
. "${dir_bashlib}/500kv.bash"

# -----------------------------------------------------------------------------
# cleanup
# -----------------------------------------------------------------------------

unset -f _z_colour_add_esc
unset -v ${!colour_*} ${colours[*]} colours ${props[*]} props
