function get_color --description 'Get the partial escape code for a terminal colour'
  switch $argv[1]
  case normal reset
    echo "0"
  case '*'
    set_color $argv \
    | string split \x1b \
    | string replace -afr '\[(\d+)m' '$1' \
    | string join ';'
  end
end

if not set -q __zgm_init_colours
  set -l message "Sourcing colours…"
  if in-path lolcat
    echo $message | lolcat --animate
  else
    set -l colours f00 f70 fa0 ff0 cf0 8f0 0f0 0f9 0f9 0fe 0df 08f 04f 30f 60f b0f f0e
    for i in (seq 1 (count $colours))
      echo -ns (set_color $colours[$i]) (string sub --start $i --length 1 "$message")
    end
    echo (set_color normal)
  end

  # default color
  set -U fish_color_normal normal

  # commands
  set -U fish_color_command white --bold

  # quoted blocks of text
  set -U fish_color_quote cyan

  # IO redirections
  set -U fish_color_redirection yellow

  # process separators like ';' and '&'
  set -U fish_color_end bryellow

  # "potential errors"
  set -U fish_color_error red

  # regular command parameters
  set -U fish_color_param white

  # code comments
  set -U fish_color_comment brblack --italics

  # matching parentheses
  set -U fish_color_match brcyan --underline

  # selected text (in vi visual mode)
  set -U fish_color_selection --background=brblack white

  # history search matches (background colour)
  set -U fish_color_search_match --background=black

  # parameter expansion operators like '*', '~', and '()'
  set -U fish_color_operator bryellow

  # character escapes like '\n' and '\x70'
  set -U fish_color_escape brmagenta

  # autosuggestions
  set -U fish_color_autosuggestion brblack

  # the current working directory in the default prompt
  set -U fish_color_cwd brwhite

  # the current username in some default prompts
  set -U fish_color_user blue

  # the current host system in some default prompts
  set -U fish_color_host brblack

  # the '^C' indicator on a canceled command
  set -U fish_color_cancel red

  # ---------------------------------------------------------------------------
  # completion highlighting
  # ---------------------------------------------------------------------------

  # the prefix string, i.e. the string that is to be completed
  set -U fish_pager_color_prefix brblack

  # the completion itself
  set -U fish_pager_color_completion white

  # the completion description
  set -U fish_pager_color_description brblack --italics

  # the progress bar at the bottom left corner
  set -U fish_pager_color_progress blue

  # every second completion's background colour
  set -U fish_pager_color_secondary --background=normal

  # ---------------------------------------------------------------------------
  # undocumented
  # ---------------------------------------------------------------------------

  set -U fish_color_valid_path green --underline
  set -U fish_color_history_current blue
  set -U fish_color_cwd_root red

  set -U fish_color_status brblue
  set -U fish_color_dimmed brblack
  set -U fish_color_separator brwhite

  # ---------------------------------------------------------------------------
  # prompt
  # ---------------------------------------------------------------------------

  set -U fish_color_user_root $fish_color_cwd_root
  set -U fish_prompt_color_clock $fish_color_dimmed
  set -U fish_prompt_color_duration $fish_color_dimmed
  set -U fish_prompt_color_exit $fish_color_error
  set -U fish_prompt_color_git_branch $fish_color_dimmed
  set -U fish_prompt_color_git_stashed $fish_color_dimmed
  set -U fish_prompt_color_git_needs_add red
  set -U fish_prompt_color_git_needs_commit yellow
  set -U fish_prompt_color_git_needs_push cyan
  set -U fish_prompt_color_git_clean green
  set -U fish_prompt_color_jobs yellow

  set -U __zgm_init_colours ✓
end

# -----------------------------------------------------------------------------
# LS_COLORS
# -----------------------------------------------------------------------------

set ls_colors_file "$XDG_CACHE_HOME/dircolors/thirty2k.ls_colors.fish"

if test ! -f $ls_colors_file -a -d (dirname $ls_colors_file)
  pushd (dirname $ls_colors_file)
    and make --quiet all
  popd
end

if test -f $ls_colors_file
  set -gx LS_COLORS (string replace -a "'" "" < $ls_colors_file | string split ' ')[3]
end

set --erase ls_colors_file

if not is-gnu ls
  # Generated at http://geoff.greer.fm/lscolors/
  set -gx CLICOLOR 1
  set -gx LSCOLORS 'exFxdacabxgagaabadHbHd'
end

# -----------------------------------------------------------------------------
# other
# -----------------------------------------------------------------------------

set -gx GCC_COLORS \
  "error="(get_color brred) \
  "warning="(get_color yellow) \
  "note="(get_color blue) \
  "caret="(get_color brmagenta) \
  "locus="(get_color brblack) \
  "quote="(get_color cyan)

set -gx GREP_COLORS "sl=0" "cx="(get_color brblack) "se="(get_color brblack) \
  "mt="(get_color magenta --underline) "ms="(get_color brmagenta --underline) \
  "mc="(get_color magenta --underline) \
  "fn="(get_color blue) "ln="(get_color cyan) "bn="(get_color green)

begin
  set -l jq_null (get_color brblack)
  set -l jq_false (get_color brred)
  set -l jq_true (get_color brgreen)
  set -l jq_int (get_color magenta)
  set -l jq_str (get_color cyan)
  set -l jq_arr (get_color normal)
  set -l jq_obj (get_color normal)
  set -gx JQ_COLORS $jq_null $jq_false $jq_true $jq_int $jq_str $jq_arr $jq_obj
end

set GCC_COLORS (string join : $GCC_COLORS)
set GREP_COLORS (string join : $GREP_COLORS)
set JQ_COLORS (string join : $JQ_COLORS)

# -----------------------------------------------------------------------------
# exa
# -----------------------------------------------------------------------------

if in-path exa
  set -gx EXA_COLORS (string replace -a "=9" "=1;3" "$LS_COLORS" | string split :)
  # Permissions & attributes
  set -a EXA_COLORS "ur="(get_color yellow)
  set -a EXA_COLORS "uw="(get_color red)
  set -a EXA_COLORS "ux="(get_color green)
  set -a EXA_COLORS "ue="(get_color green --bold)
  set -a EXA_COLORS "gr="(get_color yellow)
  set -a EXA_COLORS "gw="(get_color red)
  set -a EXA_COLORS "gx="(get_color green)
  set -a EXA_COLORS "tr="(get_color yellow)
  set -a EXA_COLORS "tw="(get_color red)
  set -a EXA_COLORS "tx="(get_color green)
  set -a EXA_COLORS "su="(get_color cyan)
  set -a EXA_COLORS "sf="(get_color cyan)
  set -a EXA_COLORS "xa="(get_color white --bold)
  # File sizes
  set -a EXA_COLORS "sn="(get_color cyan)
  set -a EXA_COLORS "sb="(get_color cyan --bold)
  set -a EXA_COLORS "df="(get_color cyan --bold)
  set -a EXA_COLORS "ds="(get_color cyan)
  # Owners and groups
  set -a EXA_COLORS "uu="(get_color green)
  set -a EXA_COLORS "un="(get_color yellow)
  set -a EXA_COLORS "gu="(get_color green)
  set -a EXA_COLORS "gn="(get_color yellow)
  # Hard links
  set -a EXA_COLORS "lc="(get_color white --bold)
  set -a EXA_COLORS "lm="(get_color white)
  # git
  set -a EXA_COLORS "ga="(get_color green --bold)
  set -a EXA_COLORS "gm="(get_color yellow --bold)
  set -a EXA_COLORS "gd="(get_color red --bold)
  set -a EXA_COLORS "gv="(get_color cyan)
  set -a EXA_COLORS "gt="(get_color cyan)
  # Details and metadata
  set -a EXA_COLORS "xx="(get_color normal)
  set -a EXA_COLORS "da="(get_color normal)
  set -a EXA_COLORS "in="(get_color white)
  set -a EXA_COLORS "bl="(get_color cyan)
  set -a EXA_COLORS "hd="(get_color white --underline)
  set -a EXA_COLORS "lp="(get_color magenta)
  set -a EXA_COLORS "cc="(get_color red --bold)
  set -a EXA_COLORS "bO="(get_color --background=black magenta)

  set EXA_COLORS (string join : $EXA_COLORS)
end
