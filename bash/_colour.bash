# -----------------------------------------------------------------------------
# ~/.config/bash/_colour.bash
# -----------------------------------------------------------------------------

# get the terminal colour depth (based on $TERM, not perfect but it'll do)
if [[ -z $TERM_COLOURDEPTH || -n $Z_RELOADING ]]; then
  TERM_COLOURDEPTH="$(tput -T"${PTERM:-$TERM}" colors 2>/dev/null ||
                      tput -T"${PTERM:-$TERM}" Co 2>/dev/null)" || return
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
props=([0]=reset [1]=bold [2]=faint [4]=ul [5]=blink [7]=inv)

# PuTTY renders italics as inverted text for some reason.
if [[ $TERM_PROGRAM != "PuTTY" && $TERM != putty* && $PTERM != putty* ]]; then
  props+=([3]=italic)
fi

for p in "${!props[@]}"; do
  printf -v "${props[p]}" "$p"
done

# basic ANSI colours
colours=(
  [0]=black   [1]=red   [2]=green   [3]=yellow    [4]=blue
  [5]=magenta [6]=cyan  [7]=white   [9]=default
)

for c in "${!colours[@]}"; do
  printf -v "${colours[c]}"   $(( 30 + c ))
  # printf -v "bg${colours[c]}" $(( 40 + c ))

  [[ $v == brdefault ]] && continue # There's no "bright default" colour.

  # Use aixterm codes to get actual *bright* colours where supported, instead
  # of relying on the emulator to display bold text as bright-but-unbold.
  # (Inspired by Prompt, which doesn't offer that option.)
  if (( TERM_COLOURDEPTH >= 16 )); then
    printf -v "br${colours[c]}"   $((  90 + c ))
    # printf -v "bgbr${colours[c]}" $(( 100 + c ))
  else
    printf -v "br${colours[c]}"   ${!colours[c]}
    # printf -v "bgbr${colours[c]}" $(( ${!colours[c]} + 10 ))
  fi

  colours+=("br${colours[c]}")
  # colours+=("bg${colours[c]}" "bgbr${colours[c]}" )
done

unset -v p c

# -----------------------------------------------------------------------------
# semantic colours
# -----------------------------------------------------------------------------

# used in PS1 -- see _prompt.bash
: ${colour_user:=$blue}

colour_true=$green
colour_false=$red

colour_hi=$brwhite   # highlight colour
colour_dim=$brblack  # secondary colour

case $TERM_PROGRAM in
  Apple_Terminal)
    if (( ${TERM_PROGRAM_VERSION%%.*} >= 377 )); then
      colour_dim=$faint
    fi
    ;;
  iTerm.app)
    colour_dim=$faint
    ;;
esac

colours+=(colour_true colour_false colour_hi colour_dim colour_user)
colours+=(reset)

# ------------------------------------------------------------------------------
# add escape codes
# ------------------------------------------------------------------------------

_z_colour_add_esc()
{
  local -a indexes=("$@")
  local index var

  for index in "${indexes[@]}"; do
    var="esc_${index#*_}"
    # $green -> $esc_green, $colour_true -> $esc_true

    if [[ -n ${!index} && -z ${!var} ]] || [[ -n $Z_RELOADING ]]; then
      printf -v "$var" "${CSI}${!index}m"
    fi
  done
}

_z_colour_add_esc ${colours[*]} ${props[*]}

# -----------------------------------------------------------------------------
# grep
# -----------------------------------------------------------------------------

if (( TERM_COLOURDEPTH >= 16 )); then
  export GREP_COLORS=""

  # Whole selected (matching) lines; or non-matching lines if -v is specified
  GREP_COLORS+="sl=${reset}:"
  # Whole context (non-matching) lines; or matching lines if -v is specified
  GREP_COLORS+="cx=${colour_dim}:"
  # # Reverses `sl` and `cx` if -v is specified (omit to set it to false)
  # GREP_COLORS+="rv:"
  # Matching text in any matching line, regardless of -v
  GREP_COLORS+="mt=${magenta}:"
  # Matching text in a selected line (if -v is omitted)
  GREP_COLORS+="ms=${brmagenta}:"
  # Matching text in a context line (if -v is specified)
  GREP_COLORS+="mc=${magenta}:"
  # Filename in line prefix
  GREP_COLORS+="fn=${blue}:"
  # Line number in line prefix
  GREP_COLORS+="ln=${cyan}:"
  # Byte offset in line prefix
  GREP_COLORS+="bn=${green}:"
  # Separators between fields in selected/context lines, etc.
  GREP_COLORS+="se=${colour_dim}"

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
GCC_COLORS+="warning=${yellow}:"
GCC_COLORS+="note=${blue}:"
GCC_COLORS+="caret=${brmagenta}:"
GCC_COLORS+="locus=${colour_dim}:"
GCC_COLORS+="quote=${cyan}"

# 500 kV library for cool colour printing
export HV_BG="reset"
. ~/lib/bash/hvdc/wtf.bash

# -----------------------------------------------------------------------------
# cleanup
# -----------------------------------------------------------------------------

unset -f _z_colour_add_esc
unset -v ${!colour_*} ${colours[*]} colours ${props[*]} props
