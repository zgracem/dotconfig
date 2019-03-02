if not set -q __zgm_init_colours
  echo -s (set_color ff0000) S (set_color ff7100) o (set_color ffa900) u \
          (set_color fff800) r (set_color c5fc00) c (set_color 8bff00) i \
          (set_color 00ff07) n (set_color 00ff9a) "g " (set_color 00ffe8) c \
          (set_color 00ddff) o (set_color 008fff) l (set_color 0040ff) o \
          (set_color 3100ff) u (set_color 6900ff) r (set_color b800ff) s \
          (set_color ff00ec) … (set_color normal)

  set -U __zgm_init_colours ✓

  # the default color
  set -U fish_color_normal normal

  # the color for commands
  set -U fish_color_command white --bold

  # the color for quoted blocks of text
  set -U fish_color_quote cyan

  # the color for IO redirections
  set -U fish_color_redirection yellow

  # the color for process separators like ';' and '&'
  set -U fish_color_end br$fish_color_quote

  # the color used to highlight "potential errors"
  set -U fish_color_error red

  # the color for regular command parameters
  set -U fish_color_param normal

  # the color used for code comments
  set -U fish_color_comment brblack --italics

  # the color used to highlight matching parentheses
  set -U fish_color_match cyan

  # the color used when selecting text (in vi visual mode)
  set -U fish_color_selection --background=brblack white

  # the background color used to highlight history search matches
  set -U fish_color_search_match --background=black

  # the color for parameter expansion operators like '*', '~', and '()'
  set -U fish_color_operator br$fish_color_redirection

  # the color used to highlight character escapes like '\n' and '\x70'
  set -U fish_color_escape brmagenta

  # the color used for autosuggestions
  set -U fish_color_autosuggestion brblack

  # the color used for the current working directory in the default prompt
  set -U fish_color_cwd brwhite

  # the color used to print the current username in some default prompts
  set -U fish_color_user blue

  # the color used to print the current host system in some default prompts
  set -U fish_color_host brblack

  # the color for the '^C' indicator on a canceled command
  set -U fish_color_cancel red

  # ---------------------------------------------------------------------------
  # completion highlighting
  # ---------------------------------------------------------------------------

  # the color of the prefix string, i.e. the string that is to be completed
  set -U fish_pager_color_prefix brblack

  # the color of the completion itself
  set -U fish_pager_color_completion white

  # the color of the completion description
  set -U fish_pager_color_description brblack --italics

  # the color of the progress bar at the bottom left corner
  set -U fish_pager_color_progress blue

  # the background color of the every second completion
  set -U fish_pager_color_secondary --background=normal

  # ---------------------------------------------------------------------------
  # undocumented
  # ---------------------------------------------------------------------------

  set -U fish_color_valid_path green --underline
  set -U fish_color_history_current blue
  set -U fish_color_cwd_root red

  set -U fish_color_status blue
  set -U fish_color_dimmed brblack
  set -U fish_color_separator brwhite

  # ---------------------------------------------------------------------------
  # prompt
  # ---------------------------------------------------------------------------

  set -U fish_color_user_root $fish_color_cwd_root
  set -U __fish_prompt_color_clock $fish_color_dimmed
  set -U __fish_prompt_color_duration $fish_color_dimmed
  set -U __fish_prompt_color_exit $fish_color_error
  set -U __fish_prompt_color_git_branch $fish_color_dimmed
  set -U __fish_prompt_color_git_stashed $fish_color_dimmed
  set -U __fish_prompt_color_git_needs_add red
  set -U __fish_prompt_color_git_needs_commit yellow
  set -U __fish_prompt_color_git_needs_push cyan
  set -U __fish_prompt_color_git_clean green
  set -U __fish_prompt_color_jobs yellow
end

# -----------------------------------------------------------------------------
# LS_COLORS
# -----------------------------------------------------------------------------

set ls_colors_file "$XDG_CACHE_HOME/dircolors/thirty2k.ls_colors.fish"

if [ -d "$XDG_CACHE_HOME/dircolors" -a ! -f "$ls_colors_file" ]
  pushd "$XDG_CONFIG_HOME/dircolors"
    and make --quiet all
    and popd
end

if [ -f "$ls_colors_file" ]
  set -gx LS_COLORS (string replace -a "'" "" < $ls_colors_file | string split ' ')[3]
end

set --erase ls_colors_file

if not is-gnu ls
  # Generated at http://geoff.greer.fm/lscolors/
  set -gx CLICOLOR 1
  set -gx LSCOLORS 'exFxdacabxgagaabadHbHd'
end

# -----------------------------------------------------------------------------
# colourize man pages
# -----------------------------------------------------------------------------

# begin/end "bold" mode -- used for man page headers
set -gx LESS_TERMCAP_md (set_color green)
set -gx LESS_TERMCAP_me (set_color normal)

# begin/end "underline" mode -- used to highlight variables
set -gx LESS_TERMCAP_us (set_color yellow)
set -gx LESS_TERMCAP_ue (set_color normal)

# reset everything
set -gx LESS_TERMEND (set_color normal)

# -----------------------------------------------------------------------------
# other
# -----------------------------------------------------------------------------

set -gx GCC_COLORS  "error=91:warning=33:note=34:caret=95:locus=90:quote=36"
set -gx GREP_COLORS "sl=0:cx=90:mt=4;35:ms=4;95:mc=4;35:fn=34:ln=36:bn=32:se=90"

# -----------------------------------------------------------------------------
# exa
# -----------------------------------------------------------------------------

if in-path exa
  set -gx EXA_COLORS (string replace -a "=9" "=1;3" "$LS_COLORS")
  set EXA_COLORS "$EXA_COLORS:ur=33"
  set EXA_COLORS "$EXA_COLORS:uw=31"
  set EXA_COLORS "$EXA_COLORS:ux=32"
  set EXA_COLORS "$EXA_COLORS:ue=1;32"
  set EXA_COLORS "$EXA_COLORS:gr=33"
  set EXA_COLORS "$EXA_COLORS:gw=31"
  set EXA_COLORS "$EXA_COLORS:gx=32"
  set EXA_COLORS "$EXA_COLORS:tr=33"
  set EXA_COLORS "$EXA_COLORS:tw=31"
  set EXA_COLORS "$EXA_COLORS:tx=32"
  set EXA_COLORS "$EXA_COLORS:su=36"
  set EXA_COLORS "$EXA_COLORS:sf=36"
  set EXA_COLORS "$EXA_COLORS:xa=1;37"
  set EXA_COLORS "$EXA_COLORS:sn=36"
  set EXA_COLORS "$EXA_COLORS:sb=1;36"
  set EXA_COLORS "$EXA_COLORS:df=1;36"
  set EXA_COLORS "$EXA_COLORS:ds=36"
  set EXA_COLORS "$EXA_COLORS:uu=32"
  set EXA_COLORS "$EXA_COLORS:un=33"
  set EXA_COLORS "$EXA_COLORS:gu=32"
  set EXA_COLORS "$EXA_COLORS:gn=33"
  set EXA_COLORS "$EXA_COLORS:lc=1;37"
  set EXA_COLORS "$EXA_COLORS:lm=37"
  set EXA_COLORS "$EXA_COLORS:ga=1;32"
  set EXA_COLORS "$EXA_COLORS:gm=1;33"
  set EXA_COLORS "$EXA_COLORS:gd=1;31"
  set EXA_COLORS "$EXA_COLORS:gv=36"
  set EXA_COLORS "$EXA_COLORS:gt=36"
  set EXA_COLORS "$EXA_COLORS:xx=0"
  set EXA_COLORS "$EXA_COLORS:da=39"
  set EXA_COLORS "$EXA_COLORS:in=37"
  set EXA_COLORS "$EXA_COLORS:bl=36"
  set EXA_COLORS "$EXA_COLORS:hd=4;37"
  set EXA_COLORS "$EXA_COLORS:lp=35"
  set EXA_COLORS "$EXA_COLORS:cc=1;31"
  set EXA_COLORS "$EXA_COLORS:bO=35;40"
end
