set -l fish_theme thirty2k

if fish-is-newer-than 4.3
    fish_config theme choose --color-theme=dark $fish_theme
else
    set -l fish_theme_file $__fish_config_dir/themes/$fish_theme.theme
    set -l __fish_color_rx '^fish_(?:pager_)?color_\w+ (.*)$'

    while read line
        string match -rq $__fish_color_rx $line; or continue
        set -l varname (string split -f1 " " $line)
        set -l vardef (string match -rg $__fish_color_rx $line | string split " ")
        set -gx $varname $vardef
    end <$__fish_config_dir/themes/$fish_theme.theme
end

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
