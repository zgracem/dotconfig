function wtf -d "Display information about commands"
    set -q argv[1]; or return 1
    set -f reset (set_color $fish_color_normal)

    for subject in $argv
        set -l types (type -at $subject 2>/dev/null)
        contains -- $subject (abbr --list); and set -p types abbreviation
        contains -- $subject (set --names); and set -p types variable

        if test (count $filetypes) -eq 0
            if path is $subject; or test -L $subject
                __wtf_file $subject; or return
                continue
            else
                echo >&2 "not found: $subject"
                return 1
            end
        end

        for type in $filetypes
            switch $filetype
                case function
                    functions $subject
                case builtin
                    printf "%s is a builtin\n" (__wtf_print $fish_color_keyword $subject)
                case file
                    printf "%s is an executable\n" (__wtf_print $fish_color_command $subject)
                    set -l paths (type -aP $subject)
                    __wtf_list $paths
                case abbreviation
                    printf "%s is an abbreviation\n" (__wtf_print $fish_color_quote $subject)
                    abbr --show | string match -er -- "-- $subject\b" | fish_indent --ansi
                case variable
                    printf "%s is a variable\n" (__wtf_print $fish_color_operator "\$$subject")
                    set --show $subject
            end
        end
    end
end

function __wtf_file
    set -f file (path normalize $argv[1])

    if not path is $file; and not test -L $file
        echo >&2 "not found: $file"
        return 1
    end

    set -l filetype (gstat -c "%F" $file)
    set -l fileinfo (file -bp $file | string split ", " | string trim)
    set -l print_file (__wtf_print $fish_color_valid_path $file)

    if string match -q "symbolic link" $filetype
        if path is $file
            set -l target (path resolve $file)
            printf "%s is a symlink to %s\n" (__wtf_print -u cyan $file) (__wtf_print $fish_color_valid_path $target)
            set -l file $target
            set -l filetype (gstat -c "%F" $target)
            set -l fileinfo (file -bp $target | string split ", " | string trim)
        else
            set -l target (string match -rg "broken symbolic link to (.+)" $fileinfo[1])
            printf "%s is a broken symlink to %s\n" (__wtf_print -u cyan $file) (__wtf_print $fish_color_error $target)
            return
        end
    end

    switch $filetype
        case "* special file"
            set -l devices (gstat -c "%Hr,%Lr" $file | string split ,)
            printf "%s is a %s (%d,%d)\n" $print_file $filetype $devices
        case socket
            set -l devices (gstat -c "%Hd,%Ld" $file | string split ,)
            printf "%s is a %s (%d,%d)\n" $print_file $filetype $devices
        case fifo
            printf "%s is a %s (named pipe)\n" $print_file $filetype
        case directory
            printf "%s is a %s\n" $print_file $filetype
            string match -q directory $fileinfo[2]; and set -e fileinfo[2]
        case "regular file"
            string match -q "*sticky*" $fileinfo[1]; and set -f -e fileinfo[1]
            string match -q "set*id" $fileinfo[1]; and set -f -e fileinfo[1]
            printf "%s is a %s (%s)\n" $print_file $filetype $fileinfo[1]
        case "symbolic link"
            : # handled above
        case "*"
            echo >&2 "$file: unknown type: $filetype"
            return 1
    end

    test -g $file; and set -f -a fileinfo "set-group-ID bit set"
    test -u $file; and set -f -a fileinfo "set-user-ID bit set"
    test -k $file; and set -f -a fileinfo "sticky bit set"

    if set -q fileinfo[2]
        set -l bullet (__wtf_print normal --dim "*")
        printf "$bullet %s\n" $fileinfo[2..]
    end
end

function __wtf_list
    if command -q eza
        eza -aldg --sort none $argv
    else
        ls -alhd --color=auto $argv
    end
end

function __wtf_print
    set -l colour $argv[1..-2]
    set -l text $argv[-1]

    echo -ns (set_color $colour) $text (set_color $fish_color_normal)
end
