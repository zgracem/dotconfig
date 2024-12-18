set -q __zgm_init_colours
and return

set -l message "Sourcing colours…"
if command -q lolcat
    echo $message | lolcat --animate
else
    echo $message
end

# https://fishshell.com/docs/current/interactive.html#syntax-highlighting-variables
set -U fish_color_normal normal
set -U fish_color_command white --bold
set -U fish_color_keyword brmagenta
set -U fish_color_quote cyan
set -U fish_color_redirection yellow # IO redirections like `>/dev/null`
set -U fish_color_end yellow # process separators like `;` and `&`
set -U fish_color_error brred # syntax errors
set -U fish_color_param normal # ordinary command parameters
set -U fish_color_valid_path green --underline # filename parameters (if the file exists)
set -U fish_color_option white # options starting with `-`
set -U fish_color_comment brblack --italics # comments like `# TODO`
set -U fish_color_selection white --background=brblack # selected text (in vi visual mode)
set -U fish_color_operator bryellow # parameter expansion operators like '*' and '~'
set -U fish_color_escape brred # character escapes like '\n' and '\x70'
set -U fish_color_autosuggestion brblack
set -U fish_color_cwd brwhite # the current directory in the default prompt
set -U fish_color_cwd_root red # ditto, but for the root user
set -U fish_color_user brblack # the username in some default prompts
set -U fish_color_at normal # the '@' in 'user@host'
set -U fish_color_host brblack # the hostname in some default prompts
set -U fish_color_host_remote brblack # ditto for remote sessions (like ssh)
set -U fish_color_status $fish_color_error # the last command's nonzero exit code in the default prompt
set -U fish_color_cancel red # the '^C' indicator on a canceled command
set -U fish_color_search_match --background=black # history search matches & pager selections (background colour)
set -U fish_color_history_current blue # used by `dirh`

# completion highlighting
set -U fish_pager_color_progress blue # "…and 6 more rows" in the bottom left corner
# unselected lines
set -U fish_pager_color_background --background=normal # the background color of a line
set -U fish_pager_color_prefix brblack # the un-completed (incomplete) string
set -U fish_pager_color_completion normal # the proposed completion suffix
set -U fish_pager_color_description $fish_color_comment # the completion description
# selected line
set -U fish_pager_color_selected_background --background=brblack
set -U fish_pager_color_selected_prefix --dim
set -U fish_pager_color_selected_completion brwhite --bold
set -U fish_pager_color_selected_description --italics

# ---------------------------------------------------------------------------
# $__fish_config_dir/prompt
# ---------------------------------------------------------------------------

set -U fish_prompt_color_ps blue
set -U fish_prompt_color_ps_root $fish_color_cwd_root
set -U fish_prompt_color_duration --dim
set -U fish_prompt_color_jobs yellow
set -U fish_prompt_color_rbenv brmagenta
set -U __fish_git_prompt_color_branch --dim --italics
set -U __fish_git_prompt_color_stashstate --dim
set -U __fish_git_prompt_color_dirtystate red
set -U __fish_git_prompt_color_stagedstate yellow
set -U __fish_git_prompt_color_upstream cyan
set -U __fish_git_prompt_color_cleanstate green

# ----------------------------------------------------------------------------
# other
# ----------------------------------------------------------------------------

# LS_COLORS
if command -q eza
    set --erase LS_COLORS EXA_COLORS EZA_COLORS
else if is-gnu ls; and path is -d $XDG_CONFIG_HOME/dircolors
    set -l ls_colors_file "$XDG_DATA_HOME/dircolors/thirty2k.ls_colors.fish"
    make -s -C $XDG_DATA_HOME/dircolors
    set -Ux LS_COLORS (string match -r "(?<=')(?:[^=]+=(?:[\d;]+|target):)+" <$ls_colors_file)
else
    # Generated at http://geoff.greer.fm/lscolors/
    set -Ux CLICOLOR 1
    set -Ux LSCOLORS exFxdacabxgagaabadHbHd
end

# gcc
set -Ux --path GCC_COLORS
set -a GCC_COLORS "error="(get_color $fish_color_error)
set -a GCC_COLORS "warning="(get_color yellow)
set -a GCC_COLORS "note="(get_color blue)
set -a GCC_COLORS "caret="(get_color brmagenta)
set -a GCC_COLORS "locus="(get_color --dim)
set -a GCC_COLORS "quote="(get_color $fish_color_quote)

# grep
set -Ux --path GREP_COLORS
set -Ua GREP_COLORS "se="(get_color --dim)
set -Ua GREP_COLORS "mt="(get_color brmagenta --underline)
set -Ua GREP_COLORS "fn="(get_color blue)
set -Ua GREP_COLORS "ln="(get_color cyan)

# jq
set -Ux --path JQ_COLORS
begin
    set -l jq_nil (get_color --dim)
    set -l jq_non (get_color brred)
    set -l jq_oui (get_color brgreen)
    set -l jq_int (get_color magenta)
    set -l jq_str (get_color $fish_color_quote)
    set -l jq_arr (get_color normal)
    set -l jq_obj (get_color normal)
    set -Ua JQ_COLORS $jq_nil $jq_non $jq_oui $jq_int $jq_str $jq_arr $jq_obj
end

set -U __zgm_init_colours ✓
