# https://fishshell.com/docs/current/interactive.html#syntax-highlighting-variables
set -g fish_color_normal normal
set -g fish_color_command white --bold
set -g fish_color_keyword brmagenta
set -g fish_color_quote cyan
set -g fish_color_redirection yellow # IO redirections like `>/dev/null`
set -g fish_color_end yellow # process separators like `;` and `&`
set -g fish_color_error brred # syntax errors
set -g fish_color_param normal # ordinary command parameters
set -g fish_color_valid_path green --underline # filename parameters (if the file exists)
set -g fish_color_option white # options starting with `-`
set -g fish_color_comment brblack --italics # comments like `# TODO`
set -g fish_color_selection white --background=brblack # selected text (in vi visual mode)
set -g fish_color_operator bryellow # parameter expansion operators like '*' and '~'
set -g fish_color_escape brred # character escapes like '\n' and '\x70'
set -g fish_color_autosuggestion brblack
set -g fish_color_cwd brwhite # the current directory in the default prompt
set -g fish_color_cwd_root red # ditto, but for the root user
set -g fish_color_user brblack # the username in some default prompts
set -g fish_color_at normal # the '@' in 'user@host'
set -g fish_color_host brblack # the hostname in some default prompts
set -g fish_color_host_remote brblack # ditto for remote sessions (like ssh)
set -g fish_color_status $fish_color_error # the last command's nonzero exit code in the default prompt
set -g fish_color_cancel red # the '^C' indicator on a canceled command
set -g fish_color_search_match --background=black # history search matches & pager selections (background colour)
set -g fish_color_history_current blue # used by `dirh`

# completion highlighting
set -g fish_pager_color_progress blue # "…and 6 more rows" in the bottom left corner
# unselected lines
set -g fish_pager_color_background --background=normal # the background color of a line
set -g fish_pager_color_prefix brblack # the un-completed (incomplete) string
set -g fish_pager_color_completion normal # the proposed completion suffix
set -g fish_pager_color_description $fish_color_comment # the completion description
# selected line
set -g fish_pager_color_selected_background --background=brblack
set -g fish_pager_color_selected_prefix --dim
set -g fish_pager_color_selected_completion brwhite --bold
set -g fish_pager_color_selected_description --italics

# ----------------------------------------------------------------------------
# $__fish_config_dir/prompt
# ----------------------------------------------------------------------------

set -g fish_color_prompt_ps blue
set -g fish_color_prompt_ps_root $fish_color_cwd_root
set -g fish_color_prompt_duration --dim
set -g fish_color_prompt_jobs yellow
set -g fish_color_prompt_rbenv brmagenta
set -g fish_color_git_branch --dim --italics
set -g fish_color_git_stashstate --dim
set -g fish_color_git_dirtystate red
set -g fish_color_git_stagedstate yellow
set -g fish_color_git_upstream cyan
set -g fish_color_git_cleanstate green

# ----------------------------------------------------------------------------
# other
# ----------------------------------------------------------------------------

# LS_COLORS
if command -q eza
    # Colours set in $XDG_CONFIG_HOME/eza/theme.yml
    set --erase LS_COLORS EXA_COLORS EZA_COLORS
else if is-gnu ls; and path is -d $XDG_CONFIG_HOME/dircolors
    set -l ls_colors_file "$XDG_DATA_HOME/dircolors/thirty2k.ls_colors.fish"
    make -s -C $XDG_DATA_HOME/dircolors
    set -gx LS_COLORS (string match -r "(?<=')(?:[^=]+=(?:[\d;]+|target):)+" <$ls_colors_file)
else
    # Generated at http://geoff.greer.fm/lscolors/
    set -gx CLICOLOR 1
    set -gx LSCOLORS exFxdacabxgagaabadHbHd
end

# gcc
set -gx --path GCC_COLORS
set -a GCC_COLORS "error="(get_color $fish_color_error)
set -a GCC_COLORS "warning="(get_color yellow)
set -a GCC_COLORS "note="(get_color blue)
set -a GCC_COLORS "caret="(get_color brmagenta)
set -a GCC_COLORS "locus="(get_color --dim)
set -a GCC_COLORS "quote="(get_color $fish_color_quote)

# grep
set -gx --path GREP_COLORS
set -ga GREP_COLORS "se="(get_color --dim)
set -ga GREP_COLORS "mt="(get_color brmagenta --underline)
set -ga GREP_COLORS "fn="(get_color blue)
set -ga GREP_COLORS "ln="(get_color cyan)

# jq
set -gx --path JQ_COLORS
begin
    set -l jq_nil (get_color --dim)
    set -l jq_non (get_color brred)
    set -l jq_oui (get_color brgreen)
    set -l jq_int (get_color magenta)
    set -l jq_str (get_color $fish_color_quote)
    set -l jq_arr (get_color normal)
    set -l jq_obj (get_color normal)
    set -ga JQ_COLORS $jq_nil $jq_non $jq_oui $jq_int $jq_str $jq_arr $jq_obj
end
