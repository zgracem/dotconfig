# -----------------------------------------------------------------------------
# ~/.config/bash/_colour.bash
# -----------------------------------------------------------------------------

# get the terminal colour depth (based on $TERM, not perfect but it'll do)
if [[ -z $TERM_COLOURDEPTH || -n $Z_RELOADING ]]; then
  TERM_COLOURDEPTH="$(tput -T"${PTERM:-$TERM}" colors 2>/dev/null ||
                      tput -T"${PTERM:-$TERM}" Co 2>/dev/null)" || return
fi

# skip this file if the terminal can't support at least eight colours
if [[ $TERM_COLOURDEPTH -ge 8 ]]; then
  export TERM_COLOURDEPTH
else
  printf >&2 '%s: %s only has %d colours\n' \
    "${BASH_SOURCE[0]}" "${PTERM:-$TERM}" "$TERM_COLOURDEPTH"
  return
fi

# -----------------------------------------------------------------------------
# basic colours
# -----------------------------------------------------------------------------

# properties
reset=0; bold=1; faint=2; ul=4; blink=5; inv=7
props=(reset bold faint ul blink inv)

# PuTTY renders italics as inverted text for some reason.
if [[ $TERM_PROGRAM != "PuTTY" && $TERM != putty* && $PTERM != putty* ]]; then
  italic=3
  props+=(italic)
fi

# basic ANSI colours
black=30; red=31; green=32; yellow=33; blue=34;
magenta=35; cyan=36; white=37; default=39
colours=(black red green yellow blue magenta cyan white default)

if [[ $TERM_COLOURDEPTH -ge 16 ]]; then
  # Use aixterm codes to get actual *bright* colours where supported, instead
  # of relying on the emulator to display bold text as bright-but-unbold.
  # (Inspired by Prompt, which doesn't offer that option.)
  brblack=90; brred=91; brgreen=92; bryellow=93;
  brblue=94; brmagenta=95; brcyan=96; brwhite=97
else
  # fall back to bold
  brblack="1;$black"
  brred="1;$red"
  brgreen="1;$green"
  bryellow="1;$yellow"
  brblue="1;$blue"
  brmagenta="1;$magenta"
  brcyan="1;$cyan"
  brwhite="1;$white"
fi
colours+=(brblack brred brgreen bryellow brblue brmagenta brcyan brwhite)

# -----------------------------------------------------------------------------
# semantic colours
# -----------------------------------------------------------------------------

# used in PS1 -- see _prompt.bash
: "${colour_user:=$blue}"

colour_true=$green
colour_false=$red

colour_hi=$brwhite   # highlight colour
colour_dim=$brblack  # secondary colour

case $TERM_PROGRAM in
  Apple_Terminal)
    if [[ ${TERM_PROGRAM_VERSION%%.*} -ge 377 ]]; then
      colour_dim=$faint
    fi
    ;;
  iTerm.app)
    colour_dim=$faint
    ;;
esac

colours+=(colour_true colour_false colour_hi colour_dim colour_user)

# ------------------------------------------------------------------------------
# add escape codes
# ------------------------------------------------------------------------------

_z_colour_add_esc()
{
  local -a indexes=("$@")
  local index var

  # $green -> $esc_green, $colour_true -> $esc_true
  for index in "${indexes[@]}"; do
    var="esc_${index#*_}"

    if [[ -n ${!index} && -z ${!var} ]] || [[ -n $Z_RELOADING ]]; then
      printf -v "$var" "%sm" "${CSI}${!index}"
    fi
  done
}

# Leave these unquoted so they expand properly.
# shellcheck disable=SC2048,SC2086
_z_colour_add_esc ${colours[*]} ${props[*]}

# -----------------------------------------------------------------------------
# grep
# -----------------------------------------------------------------------------

if [[ $TERM_COLOURDEPTH -ge 16 ]]; then
  export GREP_COLORS=""

  # Whole selected (matching) lines; or non-matching lines if -v is specified
  GREP_COLORS+="sl=${reset}:"
  # Whole context (non-matching) lines; or matching lines if -v is specified
  GREP_COLORS+="cx=${colour_dim}:"
  # # Reverses `sl` and `cx` if -v is specified (omit to set it to false)
  # GREP_COLORS+="rv:"
  # Matching text in any matching line, regardless of -v
  GREP_COLORS+="mt=${ul};${magenta}:"
  # Matching text in a selected line (if -v is omitted)
  GREP_COLORS+="ms=${ul};${brmagenta}:"
  # Matching text in a context line (if -v is specified)
  GREP_COLORS+="mc=${ul};${magenta}:"
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
# eza
# -----------------------------------------------------------------------------

# set LS_COLORS
# shellcheck source=bashrc.d/dircolors.bash
. "${BASH_SOURCE[0]%/*}/bashrc.d/dircolors.bash"

# replace bright aixterm colour codes w/ bold ANSI codes
# shellcheck disable=SC2153
export EZA_COLORS="${LS_COLORS//=9/=1;3}"

## Normal file
EZA_COLORS+="fi=0:"
## Directory
EZA_COLORS+="di=34:"
## Executable file
EZA_COLORS+="ex=31:"
## Named pipe
EZA_COLORS+="pi=32;40:"
## Socket
EZA_COLORS+="so=33;40:"
## Block device
EZA_COLORS+="bd=36;40:"
## Character device
EZA_COLORS+="cd=36;40:"
## Symlink
EZA_COLORS+="ln=35:"
## Arrow to broken symlink
EZA_COLORS+="or=1;31:"

### PERMISSIONS

## User +r bit
EZA_COLORS+="ur=33:"
## User +w bit
EZA_COLORS+="uw=31:"
## User +x bit (files)
EZA_COLORS+="ux=1;4;32:"
## User +x bit (file types)
EZA_COLORS+="ue=1;32:"
## Group +r bit
EZA_COLORS+="gr=33:"
## Group +w bit
EZA_COLORS+="gw=31:"
## Group +x bit
EZA_COLORS+="gx=32:"
## Others +r bit
EZA_COLORS+="tr=33:"
## Others +w bit
EZA_COLORS+="tw=31:"
## Others +x bit
EZA_COLORS+="tx=32:"
## Higher bits (files)
EZA_COLORS+="su=36:"
## Higher bits (other types)
EZA_COLORS+="sf=36:"
## Extended attribute marker
EZA_COLORS+="xa=1;37:"

### FILE SIZES

## Size numbers
EZA_COLORS+="sn=36:"
## Size unit
EZA_COLORS+="sb=1;36:"
## Major device ID
EZA_COLORS+="df=1;36:"
## Minor device ID
EZA_COLORS+="ds=36:"

### OWNERS AND GROUPS

## A user that’s you
EZA_COLORS+="uu=32:"
## A user that’s not
EZA_COLORS+="un=33:"
## A group with you in it
EZA_COLORS+="gu=32:"
## A group without you
EZA_COLORS+="gn=33:"

### HARD LINKS

## Number of links
EZA_COLORS+="lc=1;37:"
## A multi-link file
EZA_COLORS+="lm=37:"

### GIT

## New
EZA_COLORS+="ga=1;32:"
## Modified
EZA_COLORS+="gm=1;33:"
## Deleted
EZA_COLORS+="gd=1;31:"
## Renamed
EZA_COLORS+="gv=36:"
## Type change
EZA_COLORS+="gt=36:"

### DETAILS AND METADATA

## Punctuation
EZA_COLORS+="xx=0:"
## Timestamp
EZA_COLORS+="da=39:"
## File inode
EZA_COLORS+="in=37:"
## Number of blocks
EZA_COLORS+="bl=36:"
## Table header row
EZA_COLORS+="hd=4;37:"
## Symlink path
EZA_COLORS+="lp=35:"
## Control character
EZA_COLORS+="cc=1;31:"

### OVERLAYS

## Broken link path
EZA_COLORS+="bO=35;40:"

### EXTENSIONS

EZA_COLORS+="*.DS_Store=30:"
# EZA_COLORS+="=:"

# -----------------------------------------------------------------------------
# miscellany
# -----------------------------------------------------------------------------

# colourize history output
if [[ $TERM_COLOURDEPTH -ge 16 ]]; then
  # shellcheck disable=SC2154
  HISTTIMEFORMAT="${esc_dim}${HISTTIMEFORMAT}${esc_reset}"
fi

# jq
export JQ_COLORS="${brblack}:${brred}:${brgreen}:${magenta}:${cyan}:${default}:${default}"

# gcc diagnostics
export GCC_COLORS=""
GCC_COLORS+="error=${brred}:"
GCC_COLORS+="warning=${yellow}:"
GCC_COLORS+="note=${blue}:"
GCC_COLORS+="caret=${brmagenta}:"
GCC_COLORS+="locus=${colour_dim}:"
GCC_COLORS+="quote=${cyan}"

# less: begin/end "bold" mode (man page headers)
LESS_TERMCAP_md="${esc_green}"
LESS_TERMCAP_me="${esc_reset}"

# less: begin/end "underline" mode (man page variables)
LESS_TERMCAP_us="${esc_yellow}"
LESS_TERMCAP_ue="${esc_reset}"

# less: reset
LESS_TERMEND="${esc_reset}"

# shellcheck disable=SC2086
export ${!LESS_TERM*}

# -----------------------------------------------------------------------------
# cleanup
# -----------------------------------------------------------------------------

# shellcheck disable=SC2048,SC2086
unset -v ${!colour_*} ${colours[*]} colours ${props[*]} props
unset -f _z_colour_add_esc
