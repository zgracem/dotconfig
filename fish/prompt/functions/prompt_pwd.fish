# Overrides $__fish_data_dir/functions/prompt_pwd.fish
function prompt_pwd --description 'Print a shortened version of a given path'
    # This function compresses a path (for use in `fish_prompt`) in a slightly
    # clearer (and more clever/complicated) way than the stock version.
    #
    # * Skips compressing dirnames already under a given length (--min-part)
    # * Always truncate dirnames longer than a given length (--max-part)
    # * Stops compressing the path once it's under a given length (--max-path)
    # * Stop compressing before the end of the path (--keep-dirs)
    #   * Works left to right, stopping at MAX_PATH by default
    # * Skip compressing the root of a git repo (--repo)
    # * Indicate which dirnames have been compressed (--glyph)
    #
    # Given the following path:
    #     /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/share/man
    # The vanilla `prompt_pwd` produces:
    #     /L/D/C/S/M/u/s/man
    # This version produces:
    #     /Lib…/Dev…/Com…/SDKs/Mac…/usr/share/man
    # It can mimic vanilla behaviour:
    #     prompt_pwd --vanilla # = -k1 -m1 -M1 -P1 -G -R
    set -l options g/glyph= G/no-glyph
    set -a options k/keep-dirs=
    set -a options m/min-part= M/max-part= P/max-path=
    set -a options r/repo R/no-repo
    set -a options V/vanilla
    set -l exclusives V,{g,G,k,m,M,P,r,R}
    set -a exclusives g,G r,R

    argparse -n (status function) -x$exclusives $options -- $argv
    or return

    set -q argv[1]
    or set argv $PWD

    # Never shorten dirnames this long (or shorter)
    set -q _flag_min_part; or set -f _flag_min_part 3

    # Always shorten dirnames this long (or longer)
    set -q _flag_max_part; or set -f _flag_max_part 11

    # Stop shortening when PWD is this length (or shorter)
    set -q _flag_max_path; or set -f _flag_max_path 40

    # Always leave this many trailing dirnames unshortened
    set -q _flag_keep_dirs; or set -f _flag_keep_dirs 1

    # Mark shortened dirnames
    set -q _flag_glyph; or set -f _flag_glyph "…"

    # Skip compressing git repos by default
    set -f _flag_repo 1

    set -q _flag_no_glyph; and set -f _flag_glyph ""
    set -q _flag_no_repo; and set -e _flag_repo

    if set -q _flag_vanilla
        set -f _flag_min_part 1
        set -f _flag_max_part 1
        set -f _flag_max_path 1
        set -f _flag_keep_dirs 1
        set -f _flag_glyph ""
        set -e _flag_repo
    end

    # Replace leading $HOME w/ '~', and split PWD into a list of dirnames
    set -f path (string replace -i -r "^$HOME" "~" $argv[1] | string split /)
    set -f pathc (seq (math (count $path) - $_flag_keep_dirs))

    # Truncate dirnames longer than MAX_PART
    for i in $pathc
        # Stop if PWD is already MAX_PATH or shorter
        test (string length "$path") -le $_flag_max_path; and break

        set -l part $path[$i]
        if test (string length $part) -gt $_flag_max_part
            set path[$i] (string sub -l$_flag_max_part $part | string trim)
            set path[$i] "$path[$i]$_flag_glyph"
        end
    end

    # Truncate dirnames longer than MIN_PART, left to right, but only if it
    # would actually shorten the string: avoids usr → us…, data → # dat…
    # etc., which obfuscates for no benefit.
    set -f actual_min_part (math $_flag_min_part + (string length $_flag_glyph))
    for i in $pathc
        # Stop if PWD is already MAX_PATH or shorter
        test (string length "$path") -le $_flag_max_path; and break

        # Skip if PWD is the root of a git repo
        if set -q _flag_repo
            set -l git_dir (string join / $path[1..$i] | string replace -r '^~' $HOME)/.git
            path is -d $git_dir; and continue
        end

        set -l part $path[$i]
        if test (string length $part) -gt $actual_min_part
            set path[$i] (string sub -l$_flag_min_part $part | string trim)
            set path[$i] "$path[$i]$_flag_glyph"
        end
    end

    string join / -- $path
end
