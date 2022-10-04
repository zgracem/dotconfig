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
    set -gx LS_COLORS (string match -r "(?<=')(?:[^=]+=[\d;]+:)+" <$ls_colors_file)
else
    # Generated at http://geoff.greer.fm/lscolors/
    set -gx CLICOLOR 1
    set -gx LSCOLORS exFxdacabxgagaabadHbHd
end

# -----------------------------------------------------------------------------
# other
# -----------------------------------------------------------------------------

# begin/end "bold" mode -- man page headers
set -gx LESS_TERMCAP_md (set_color green)
set -gx LESS_TERMCAP_me (set_color normal)

# begin/end "underline" mode -- highlights man page variables
set -gx LESS_TERMCAP_us (set_color yellow)
set -gx LESS_TERMCAP_ue (set_color normal)

# reset
set -gx LESS_TERMEND (set_color normal)

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

# -----------------------------------------------------------------------------
# exa
# -----------------------------------------------------------------------------

if in-path exa
    set -gx --path EXA_COLORS # (string split : "$LS_COLORS" | string replace -a "=9" "=1;3")

    ### Permissions & ownership

    # [u]ser/[g]roup/o[t]hers +
    #   [r]ead/[w]rite/e[x]ecute (regular)/[e]xecute (other)
    set -a EXA_COLORS "ur="(get_color256 brgreen)
    set -a EXA_COLORS "uw="(get_color256 bryellow)
    set -a EXA_COLORS "ux="(get_color256 brcyan)
    set -a EXA_COLORS "ue="(get_color256 cyan)
    set -a EXA_COLORS "gr="(get_color256 yellow)
    set -a EXA_COLORS "gw="(get_color256 brred)
    set -a EXA_COLORS "gx="(get_color256 cyan)
    set -a EXA_COLORS "tr="(get_color256 yellow)
    set -a EXA_COLORS "tw="(get_color256 brred)
    set -a EXA_COLORS "tx="(get_color256 cyan)

    # [s]etuid/setgid/sticky bits on reg[u]lar files & other [f]iles
    set -a EXA_COLORS "su="(get_color256 cyan)
    set -a EXA_COLORS "sf="(get_color256 cyan)

    # [U]sers & [g]roups; yo[u] or [n]ot you
    set -a EXA_COLORS "uu="(get_color256 green)
    set -a EXA_COLORS "un="(get_color256 yellow)
    set -a EXA_COLORS "gu="(get_color256 cyan)
    set -a EXA_COLORS "gn="(get_color256 yellow)

    ### Attributes

    # e[x]tended [a]ttributes
    set -a EXA_COLORS "xa="(get_color256 white)

    # File [s]ize: [n]umber & [b]yte unit
    set -a EXA_COLORS "sn="(get_color256 cyan)
    set -a EXA_COLORS "sb="(get_color256 cyan --bold)

    # Number of blocks
    set -a EXA_COLORS "bl="(get_color256 cyan)

    # File date
    set -a EXA_COLORS "da="(get_color256 white)

    # inode number
    set -a EXA_COLORS "in="(get_color256 normal)

    # Device's major (df) and minor (ds) ID
    set -a EXA_COLORS "df="(get_color256 cyan --bold)
    set -a EXA_COLORS "ds="(get_color256 cyan)

    # Hard links
    set -a EXA_COLORS "lc="(get_color256 white)
    set -a EXA_COLORS "lm="(get_color256 brwhite)

    ### Details & metadata

    # git
    set -a EXA_COLORS "ga="(get_color256 brgreen --bold)
    set -a EXA_COLORS "gm="(get_color256 bryellow --bold)
    set -a EXA_COLORS "gd="(get_color256 brred)
    set -a EXA_COLORS "gv="(get_color256 cyan)
    set -a EXA_COLORS "gt="(get_color256 cyan)

    # Path of a symlink
    set -a EXA_COLORS "lp="(get_color256 magenta)

    # Overlay style for broken symlinks
    set -a EXA_COLORS "bO="(get_color256 black --bold)

    # Header row of table
    set -a EXA_COLORS "hd="(get_color256 white --underline)

    # Punctuation
    set -a EXA_COLORS "xx="(get_color256 brblack)

    # Escape characters
    set -a EXA_COLORS "cc="(get_color256 brblack)
end
