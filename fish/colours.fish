if not set -q __zgm_init_colours
    set -l message "Sourcing colours…"
    if in-path lolcat
        echo $message | lolcat --animate
    else
        echo $message
    end

    # default color
    set -U fish_color_normal normal

    # commands
    set -U fish_color_command white --bold

    # keywords
    set -U fish_color_keyword brmagenta

    # quoted blocks of text
    set -U fish_color_quote cyan

    # IO redirections
    set -U fish_color_redirection yellow

    # process separators like ';' and '&'
    set -U fish_color_end yellow

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
    set -U fish_color_escape brred

    # autosuggestions
    set -U fish_color_autosuggestion brblack

    # the current working directory in the default prompt
    set -U fish_color_cwd brwhite

    # the current username in some default prompts
    set -U fish_color_user brblack

    # the current host system in some default prompts
    set -U fish_color_host brblack
    set -U fish_color_host_remote brblack

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

    set -U fish_prompt_color_ps blue
    set -U fish_prompt_color_ps_root $fish_color_cwd_root
    set -U fish_prompt_color_duration $fish_color_dimmed
    set -U fish_prompt_color_exit $fish_color_error
    set -U fish_prompt_color_git_branch $fish_color_dimmed
    set -U fish_prompt_color_git_stashed $fish_color_dimmed
    set -U fish_prompt_color_git_needs_add red
    set -U fish_prompt_color_git_needs_commit yellow
    set -U fish_prompt_color_git_needs_push cyan
    set -U fish_prompt_color_git_clean green
    set -U fish_prompt_color_jobs yellow
    set -U fish_prompt_color_ruby brmagenta

    set -U __zgm_init_colours ✓
end

# -----------------------------------------------------------------------------
# LS_COLORS
# -----------------------------------------------------------------------------

if is-gnu ls; and path is -d $XDG_CONFIG_HOME/dircolors
    set -l ls_colors_file "$XDG_CACHE_HOME/dircolors/thirty2k.ls_colors.fish"
    make --quiet -C $XDG_CONFIG_HOME/dircolors
    set -gx LS_COLORS (string match -r "(?<=')(?:[^=]+=(?:[\d;]+|target):)+" <$ls_colors_file)
else
    # Generated at http://geoff.greer.fm/lscolors/
    set -gx CLICOLOR 1
    set -gx LSCOLORS exFxdacabxgagaabadHbHd
end

# -----------------------------------------------------------------------------
# other
# -----------------------------------------------------------------------------

set -gx --path GCC_COLORS \
    "error="(get_color brred) \
    "warning="(get_color yellow) \
    "note="(get_color blue) \
    "caret="(get_color brmagenta) \
    "locus="(get_color brblack) \
    "quote="(get_color cyan)

set -gx __grep_match_color (get_color brmagenta --underline)
set -gx __grep_file_color (get_color blue)
set -gx __grep_line_color (get_color cyan)

set -gx --path GREP_COLORS "se="(get_color brblack) \
    "mt=$__grep_match_color" "fn=$__grep_file_color" "ln=$__grep_line_color"

begin
    set -l jq_null (get_color brblack)
    set -l jq_false (get_color brred)
    set -l jq_true (get_color brgreen)
    set -l jq_int (get_color magenta)
    set -l jq_str (get_color cyan)
    set -l jq_arr (get_color normal)
    set -l jq_obj (get_color normal)
    set -gx --path JQ_COLORS $jq_null $jq_false $jq_true $jq_int $jq_str $jq_arr $jq_obj
end
