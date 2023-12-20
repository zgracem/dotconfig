# Overrides $__fish_data_dir/functions/prompt_pwd.fish
function prompt_pwd --description 'Print a shortened version of a given path'
    # This function compresses a path (for use in `fish_prompt`) in a
    # slightly clearer (and more clever) way than the default version.
    #
    # * Skip compressing dirnames already under a given length (--min-part)
    # * Force compressing dirnames longer than a given length (--max-part)
    # * Stop compressing the path once it's under a given length (--max-path)
    # * Stop compressing before the end of the path (--keep-dirs)
    # * Indicate which dirnames have been compressed (--glyph)
    #
    # Given the following path:
    #     /usr/local/Homebrew/Library/Homebrew/extend/os/mac/utils
    # The default `prompt_pwd` produces:
    #     /u/l/H/L/H/e/o/m/utils
    # This version produces:
    #     /usr/loc…/Hom…/Lib…/Hom…/extend/os/mac/utils
    # For default behaviour:
    #     prompt_pwd -G -k1 -m1 -M1 -P1

    set -f options g/glyph= G/no-glyph k/keep-dirs= m/min-part= M/max-part= P/max-path=
    argparse -n (status function) $options -- $argv
    or return

    set -q argv[1]
    or set argv $PWD

    # Never shorten dirnames this long (or shorter)
    set -q _flag_min_part
    and set -f fish_prompt_pwd_min_part $_flag_min_part
    or set -f fish_prompt_pwd_min_part 3

    # Always shorten dirnames this long (or longer)
    set -q _flag_max_part
    and set -f fish_prompt_pwd_max_part $_flag_max_part
    or set -f fish_prompt_pwd_max_part 11

    # Stop shortening when PWD is this length (or shorter)
    set -q _flag_max_path
    and set -f fish_prompt_pwd_max_path $_flag_max_path
    or set -f fish_prompt_pwd_max_path 44

    # Always leave this many trailing dirnames unshortened
    set -q _flag_keep_dirs
    and set -f fish_prompt_pwd_keep_dirs $_flag_keep_dirs
    or set -f fish_prompt_pwd_keep_dirs 1

    # Mark shortened dirnames
    set -q _flag_glyph
    and set -f fish_prompt_pwd_glyph "$_flag_glyph"
    or set -f fish_prompt_pwd_glyph "…"

    set -q _flag_no_glyph
    and set -f fish_prompt_pwd_glyph ""

    # Replace leading $HOME w/ '~', and split PWD into a list of dirnames
    set -f path (string replace -r "^$HOME" "~" $argv[1] | string split /)
    set -f pathc (seq (math (count $path) - $fish_prompt_pwd_keep_dirs))

    # Truncate dirnames longer than MAX_PART
    for i in $pathc
        # Stop if PWD is already MAX_PATH or shorter
        test (string length "$path") -le $fish_prompt_pwd_max_path; and break

        set -l part $path[$i]
        if test (string length $part) -gt $fish_prompt_pwd_max_part
            set path[$i] (string sub -l$fish_prompt_pwd_max_part $part | string trim)
            set path[$i] "$path[$i]$fish_prompt_pwd_glyph"
        end
    end

    # Truncate dirnames longer than MIN_PART, left to right
    set -f min_actual_part (math $fish_prompt_pwd_min_part + (string length $fish_prompt_pwd_glyph))
    for i in $pathc
        # Stop if PWD is already MAX_PATH or shorter
        test (string length "$path") -le $fish_prompt_pwd_max_path; and break

        set -l part $path[$i]
        if test (string length $part) -gt $min_actual_part
            set path[$i] (string sub -l$fish_prompt_pwd_min_part $part | string trim)
            set path[$i] "$path[$i]$fish_prompt_pwd_glyph"
        end
    end

    string join / -- $path
end
