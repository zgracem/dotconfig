function wtf -d "Display information about commands"
    set -q argv[1]; or return 1
    set -f reset (set_color $fish_color_normal)

    for subject in $argv
        set -l types (type -at $subject 2>/dev/null)
        contains -- $subject (abbr --list); and set -p types abbreviation
        contains -- $subject (set --names); and set -p types variable

        if test (count $types) -eq 0
            if path is $subject; or test -L $subject
                __wtf_file $subject; or return
                continue
            else
                echo >&2 "not found: $subject"
                return 1
            end
        end

        for type in $types
            switch $type
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

    if test -L $file
        if test -e $file
            set -l target (path resolve $file)
            printf "%s is a symlink to %s\n" (__wtf_print -u cyan $file) (__wtf_print $fish_color_valid_path $target)
            set -f file $target
        else
            set -l target (file -bp $file | string match -rg "broken symbolic link to (.+)")
            printf "%s is a broken symlink to %s\n" (__wtf_print -u cyan $file) (__wtf_print $fish_color_error $target)
            return
        end
    end

    set -f type (gstat -c "%F" $file)
    set -f fileinfo (file -bp $file | string split ", " | string trim)
    set -f print_file (__wtf_print $fish_color_valid_path $file)

    if test -b $file; or test -c $file
        set -l devices (gstat -c "%Hr,%Lr" $file | string split ,)
        printf "%s is a %s (%d,%d)\n" $print_file $type $devices
    else if test -p $file
        printf "%s is a %s (named pipe)\n" $print_file $type
    else if test -S $file
        set -l devices (gstat -c "%Hd,%Ld" $file | string split ,)
        printf "%s is a %s (%d,%d)\n" $print_file $type $devices
    else if test -d $file
        printf "%s is a %s\n" $print_file $type
        string match -q directory $fileinfo[2]; and set -e fileinfo[2]
    else if test -f $file
        string match -q "*sticky*" $fileinfo[1]; and set -f -e fileinfo[1]
        string match -q "set*id" $fileinfo[1]; and set -f -e fileinfo[1]
        printf "%s is a %s (%s)\n" $print_file $type $fileinfo[1]
    else
        echo >&2 "unknown type: $file"
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
