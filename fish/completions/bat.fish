# bat <https://github.com/sharkdp/bat>
# Based on:
#   https://github.com/sharkdp/bat/blob/06b8dcb/assets/completions/bat.fish
#   https://github.com/fish-shell/fish-shell/blob/ea8a2b2/share/completions/bat.fish

function __bat_complete_files -a token
    # Cheat to complete files by calling `complete -C` on a fake command name,
    # like `__fish_complete_directories` does.
    set -l fake_command aaabccccdeeeeefffffffffgghhhhhhiiiii
    complete -C"$fake_command $token"
end

function __bat_complete_language -a comp
    command bat --list-languages | string split -f1 : | string match -e "$comp"
end

function __bat_complete_languages
    for spec in (command bat --list-languages)
        set -l name (string split -f1 : $spec)
        for ext in (string split -f2 : $spec | string split ,)
            test -n "$ext"; or continue
            string match -rq '[/*]' $ext; and continue
            printf "%s\t%s\n" $ext $name
        end
        printf "%s\t\n" $name
    end
end

function __bat_cache
    __fish_seen_subcommand_from cache
end

function __bat_complete_map_syntax
    set -l token (commandline -ct)
    set -l comps

    if string match -qr '(?<glob>.+):(?<syntax>.*)' -- $token
        # If token ends with a colon, complete with the list of language names.
        set comps $glob:(__bat_complete_language $syntax)
    else if string match -qr '\*' -- $token
        # If token contains a globbing character (`*`), complete only possible
        # globs in the current directory
        set comps (__bat_complete_files $token | string match -er '[*]'):
    else
        # Complete files (and globs).
        set comps (__bat_complete_files $token | string match -erv '/$'):
    end

    if set -q comps[1]
        printf "%s\t\n" $comps
    end
end

function __bat_no_excl
    not __bat_cache; and not __fish_seen_argument \
        -s h -l help \
        -s V -l version \
        -l config-dir -l config-file \
        -l list-languages -l list-themes
end

set -l color_opts '
    auto\tdefault
    never\t
    always\t
'
set -l decorations_opts $color_opts
set -l paging_opts $color_opts

set -l italic_text_opts '
    always\t
    never\tdefault
'

function __bat_style_opts
    set -l style_opts \
        "default,recommended components" \
        "auto,same as 'default' unless piped" \
        "full,all components" \
        "plain,no components" \
        "changes,Git change markers" \
        "header,alias for header-filename" \
        "header-filename,filename above content" \
        "header-filesize,filesize above content" \
        "grid,lines b/w sidebar, header, content" \
        "numbers,line numbers in sidebar" \
        "rule,separate files" \
        "snip,separate ranges"

    string replace , \t $style_opts
end

# While --tabs theoretically takes any number, most people should be OK with these.
# Specifying a list lets us explain what 0 does.
set -l tabs_opts '
    0\tpass\ tabs\ through\ directly
    1\t
    2\t
    4\t
    8\t
'

set -l wrap_opts '
    auto\tdefault
    never\t
    character\t
'

complete -c bat -l color -x -a "$color_opts" -d "When to use colored output" -n __bat_no_excl
complete -c bat -l config-dir -f -d "Display location of configuration directory" -n __fish_is_first_arg
complete -c bat -l config-file -f -d "Display location of configuration file" -n __fish_is_first_arg
complete -c bat -l decorations -x -a "$decorations_opts" -d "When to use --style decorations" -n __bat_no_excl
complete -c bat -s d -l diff -d "Only show lines with Git changes"
complete -c bat -l diff-content -x -d "Show N context lines around Git changes" -n "__fish_seen_argument -s d -l diff"
complete -c bat -l file-name -x -d "Specify the display name" -n __bat_no_excl
complete -c bat -s f -l force-colorization -d "Force color and decorations"
complete -c bat -s h -l help -f -d "Print help information" -n "__fish_is_first_arg; or __bat_cache"
complete -c bat -s H -l highlight-line -x -d "Highlight Nth line" -n __bat_no_excl
complete -c bat -l italic-text -x -a "$italic_text_opts" -d "When to use italic text in the output" -n __bat_no_excl
complete -c bat -s l -l language -x -k -a "(__bat_complete_languages)" -d "Set the syntax highlighting language" -n __bat_no_excl
complete -c bat -s r -l line-range -x -d "Only print lines [M]:[N] (either optional)" -n __bat_no_excl
complete -c bat -l list-languages -f -d "List syntax highlighting languages" -n __fish_is_first_arg
complete -c bat -l list-themes -f -d "List syntax highlighting themes" -n __fish_is_first_arg
complete -c bat -s m -l map-syntax -x -a "(__bat_complete_map_syntax)" -d "Map <glob pattern>:<language syntax>" -n __bat_no_excl
complete -c bat -s n -l number -d "Only show line numbers, no other decorations" -n __bat_no_excl
complete -c bat -l pager -x -a less\tdefault -d "Which pager to use" -n __bat_no_excl
complete -c bat -l paging -x -a "$paging_opts" -d "When to use the pager" -n __bat_no_excl
complete -c bat -s p -l plain -d "Disable decorations" -n __bat_no_excl
complete -c bat -o pp -d "Disable decorations and paging" -n __bat_no_excl
complete -c bat -s P -d "Disable paging" -n __bat_no_excl
complete -c bat -s A -l show-all -d "Show non-printable characters" -n __bat_no_excl
complete -c bat -l style -x -k -a "(__fish_complete_list , __bat_style_opts)" -d "Configure which elements to display in addition to file contents" -n __bat_no_excl
complete -c bat -l tabs -x -a "$tabs_opts" -d "Set tab width" -n __bat_no_excl
complete -c bat -l terminal-width -x -d "Set terminal width, +offset, or -offset" -n __bat_no_excl
complete -c bat -l theme -x -a "(command bat --list-themes | command cat)" -d "Set the syntax highlighting theme" -n __bat_no_excl
complete -c bat -s V -l version -f -d "Show version information" -n __fish_is_first_arg
complete -c bat -l wrap -x -a "$wrap_opts" -d "Text-wrapping mode" -n __bat_no_excl

# Sub-command "cache" completions
complete -c bat -a cache -d "Modify the syntax/language definition cache" -n __fish_is_first_arg
complete -c bat -l build -f -d "Parse new definitions into cache" -n __bat_cache
complete -c bat -l clear -f -d "Reset definitions to defaults" -n __bat_cache
complete -c bat -l blank -f -d "Overwrite default data instead of appending" -n "__bat_cache; and __fish_seen_argument -l build"
complete -c bat -l source -x -a "(__fish_complete_directories)" -d "Load cache from DIR" -n "__bat_cache; and __fish_seen_argument -l build"
complete -c bat -l target -x -a "(__fish_complete_directories)" -d "Store cache in DIR" -n "__bat_cache; and __fish_seen_argument -l build -l clear"
