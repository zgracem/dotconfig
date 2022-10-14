# Overrides $__fish_data_dir/functions/prompt_pwd.fish
function prompt_pwd --description 'Print the current working directory, shortened to fit the prompt'
    set -q argv[1]; or set -l argv $PWD

    set -l glyph "…"

    set -l min_part 3
    set -l max_part 11
    set -l max_path 48

    # Step 0: replace leading homedir w/ a tilde
    set -l path (string replace -r "^$HOME" "~" $argv[1] | string split /)
    set -l pathc (seq (math (count $path) - 1))

    # First pass: truncate extra-long directory names
    for i in $pathc
        test (string length "$path") -le $max_path; and break

        set -l part $path[$i]
        if test (string length $part) -gt $max_part
            set path[$i] (string sub -l$max_part $part | string trim)
            set path[$i] $path[$i]$glyph
        end
    end

    # Second pass: compact leading elements
    set -l actual_min_part (math $min_part + (string length $glyph))
    for i in $pathc
        test (string length "$path") -le $max_path; and break

        set -l part $path[$i]
        if test (string length $part) -gt $actual_min_part
            set path[$i] (string sub -l$min_part $part | string trim)
            set path[$i] $path[$i]$glyph
        end
    end

    string join / -- $path
end
