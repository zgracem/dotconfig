# -----------------------------------------------------------------------------
# ~/.config/bash/colour.bash
# -----------------------------------------------------------------------------

# get the terminal colour depth (based on $TERM, not perfect but it'll do)
if [[ -z $TERM_COLOURDEPTH ]]; then
  TERM_COLOURDEPTH="$(tput colors 2>/dev/null)" || return
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

# reset
# unset -v ${colours[*]} colours ${!esc_*}
### ZGM disabled 2016-05-02 -- probably unnecessary

# properties
reset='0'
bold='1'; ul='4';
# bold='1'; ital='3'; ul='4'; blink='5'; inv='7'

# basic ANSI colours
black='30'   # 8
red='31'     # 9
green='32'   # 10
yellow='33'  # 11
blue='34'    # 12
magenta='35' # 13
cyan='36'    # 14
white='37'   # 15

colours=(reset black red green yellow blue magenta cyan white)

# bright ANSI colours
if (( TERM_COLOURDEPTH >= 16 )); then
  brblack="${bold};${black}"
  brred="${bold};${red}"
  brgreen="${bold};${green}"
  bryellow="${bold};${yellow}"
  brblue="${bold};${blue}"
  brmagenta="${bold};${magenta}"
  brcyan="${bold};${cyan}"
  brwhite="${bold};${white}"
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
base_ansi=(${colours[*]})

# -----------------------------------------------------------------------------
# semantic colours
# -----------------------------------------------------------------------------

colour_true=$green
colour_false=$red

colour_hi=$brwhite  # highlight colour
colour_2d=$brblack  # secondary colour

# used in PS1 -- see bashrc.d/prompt.bash
: ${colour_user:=$blue}

colours+=(colour_true colour_false colour_hi colour_2d colour_user)

# -----------------------------------------------------------------------------
# solarized -- http://ethanschoonover.com/solarized
# -----------------------------------------------------------------------------

# case $TERM_PROGRAM in
#   iTerm*)
#     case $ITERM_PROFILE in
#       *light*) Z_SOLARIZED=light ;;
#       Default*|Hotkey*) Z_SOLARIZED=dark ;;
#     esac
#     ;;
#   Apple_Terminal)
#     if [[ -n $TERM_PROGRAM_VERSION ]] && (( ${TERM_PROGRAM_VERSION%%.*} > 240 )); then
#       # i.e. if not running in Terminal.app on 10.5.8...
#       : # Z_SOLARIZED=dark
#     fi
#     ;;
# esac

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

  solarized_colours=(base03 base02 base01 base00 base0 base1 base2 base3 orange violet)
  colours+=(${solarized_colours[*]})
  base_ansi+=(${solarized_colours[*]})
  unset -v solarized_colours

  # re/define semantic colours
  case $Z_SOLARIZED in
    dark)
      COLORFGBG='12;8'
      colour_hi=$base2
      colour_2d=$base01
      ;;
    light)
      COLORFGBG='11;15'
      colour_hi=$base02
      colour_2d=$base1

      colour_true=$cyan
      colour_false=$orange
      ;;
  esac
fi

export Z_SOLARIZED COLORFGBG

# ------------------------------------------------------------------------------
# add escape codes
# ------------------------------------------------------------------------------

z::colour::add_esc()
{ # $green -> $esc_green, $colour_true -> $esc_true

  local -a indexes=("$@")
  local index

  for index in "${indexes[@]}"; do
    local var_name="esc_${index#*_}"

    if [[ -n ${!index} && -z ${!var_name} ]] || [[ $Z_RELOADING == true ]]; then
      eval "$var_name=\"${CSI}${!index}m\""
    fi
  done
}

z::colour::add_esc ${colours[*]}

# export everything
export ${!esc_*}

# -----------------------------------------------------------------------------
# grep
# -----------------------------------------------------------------------------

if (( TERM_COLOURDEPTH >= 16 )); then
  export GREP_COLORS=''

  GREP_COLORS+="sl=${reset}:"         # whole selected lines
  GREP_COLORS+="cx=${colour_2d}:"     # whole context lines
  GREP_COLORS+="mt=${brred}:"         # any matching text
  GREP_COLORS+="ms=${ul};${brred}:"   # matching text in a selected line
  GREP_COLORS+="mc=${brred}:"         # matching text in a context line
  GREP_COLORS+="fn=${colour_2d}:"     # filenames
  GREP_COLORS+="ln=${blue}:"          # line numbers
  GREP_COLORS+="bn=${cyan}:"          # byte offsets
  GREP_COLORS+="se=${reset}"          # separators

  # deprecated
  export GREP_COLOR="${ul};${brred}"
fi

# -----------------------------------------------------------------------------
# less -- colourize man pages
# -----------------------------------------------------------------------------

LESS_TERMCAP_mb="${esc_magenta}"        # begin blinking mode
LESS_TERMCAP_md="${esc_green}"          # begin bold mode [headers]
LESS_TERMCAP_me="${esc_reset}"          # end blink/bold mode

LESS_TERMCAP_us="${esc_yellow}"         # begin underline [variables]
LESS_TERMCAP_ue="${esc_reset}"          # end underline

LESS_TERMCAP_so="${esc_orange}"         # begin standout [info box]
LESS_TERMCAP_se="${esc_reset}"          # end standout

LESS_TERMEND="${esc_reset}"             # reset colours

export ${!LESS_TERM*}

# -----------------------------------------------------------------------------
# ls
# -----------------------------------------------------------------------------

if ! _isGNU ls; then
  # http://geoff.greer.fm/lscolors/
  export LSCOLORS='exFxdacabxgagaabadHbHd'
  export CLICOLOR=1
fi

# use dircolors(1) to set LS_COLORS

if [[ -z $LS_COLORS ]]; then
  dc_src="$dir_config/dircolors"
  dc_cache="$HOME/var/cache/dircolors"
  dc_stub="default"

  if [[ -n $Z_SOLARIZED ]]; then
    dc_stub="solarized.$Z_SOLARIZED"
  elif [[ -n $HV_LOADED ]]; then
    dc_stub="500kv.dircolors"
  fi

  dc_src_file="$dc_src/$dc_stub"
  dc_cache_file="$dc_cache/$dc_stub"

  if [[ ! -f $dc_cache_file ]] \
    && [[ -f $dc_src_file ]] \
    && _inPath dircolors
  then
    # create cache dir if it doesn't exist
    [[ -d $dc_cache ]] || mkdir -p "$dc_cache" 1>/dev/null

    # create cache file
    dircolors -b "$dc_src_file" > "$dc_cache_file"
  fi

  if [[ -f $dc_cache_file ]]; then
    # set and export LS_COLORS
    eval "$(<"$dc_cache_file")"
  fi

  unset -v ${!dc_*}
fi

# -----------------------------------------------------------------------------
# miscellany
# -----------------------------------------------------------------------------

# colourize history output
if (( TERM_COLOURDEPTH >= 16 )); then
  HISTTIMEFORMAT="${esc_2d}${HISTTIMEFORMAT}${esc_reset}"
fi

# print a red "^C" when a command is aborted
if type -P stty &>/dev/null; then
  # disable echoing of control characters
  stty -ctlecho &>/dev/null
  bind 'set echo-control-characters off'

  # print a red "^C" on SIGINT
  trap 'printf "${esc_false}^C${esc_reset}"' INT
fi

# gcc
export GCC_COLORS=1

# 500 kV library for cool colour printing
. "${dir_bashlib}/500kv.bash"

# -----------------------------------------------------------------------------
# cleanup
# -----------------------------------------------------------------------------

unset -v ${!colour_*} ${base_ansi[*]} base_ansi colours
