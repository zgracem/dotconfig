function __fish_complete_nethack_dir
    # Source: https://nethackwiki.com/wiki/Playground
    set -fx nhdirs
    set -a nhdirs /usr/games/lib/nethackdir # Linux
    set -a nhdirs /usr/local/lib/nethack # FreeBSD
    set -a nhdirs /var/games/nethack # Debian, Ubuntu, openSUSE
    set -a nhdirs /usr/local/share/nethack # FreeBSD, macOS Homebrew x64
    set -a nhdirs /opt/homebrew/share/nethack # macOS Homebrew
    set -a nhdirs /Library/NetHack/nethackdir # macOS GUI

    path filter $nhdirs
end

function __fish_complete_nethack_saves
    if __fish_seen_argument -s D
        # "Wizard" is the only valid player name in debug mode
        printf "%s\n" Wizard
        return
    end

    # Save files are named for the character, prefixed with the player's EUID,
    # and Lempel‐Ziv (.Z) compressed. Custom compilations may do otherwise, but
    # anyone meddling with that won't expect out-of-the-box accommodations.
    set -f nhdir (__fish_complete_nethack_dir)
    set -f saves (path filter $nhdir/save/$EUID*.Z | path basename -E | string match -rg "\d+(.+)")

    for s in $saves
        printf "%s\tsave game\n" $s
    end
end

function __fish_complete_nethack_scores
    set -f nhdir (__fish_complete_nethack_dir)
    set -f scorefile (path filter $nhdir/record)
    set -f pattern "\d\.\d\.\d(?: \d+){10}(?: \S{3}){4} (\S+),.*"

    if set -q scorefile[1]
        set -f scores (string match -rg $pattern <$scorefile[1] | sort -u)
        for s in $scores
            printf "%s\tplayer score\n" $s
        end
    end
end

function __fish_complete_nethack
    # Not all combinations of `-p <role>` and `-r <race>` are valid.
    # The rules are too complex to bother reproducing here.
    # The game simply ignores invalid or contradictory input. Let it ride.
    set -l roles Archeologist Barbarian Cave{,wo}man Healer Knight Monk \
        Priest{,ess} Rogue Ranger Samurai Tourist Valkyrie Wizard
    set -l races Human Elf Dwarf Gnome Orc

    string match -q roles $argv[1]
    and printf "%s\t%s\n" "@" "Random role"

    for r in $$argv[1]
        printf "%s\t%s\n" (string sub -l 3 $r) $r
    end
end

complete -c nethack --no-files
complete -c nethack -s d -l directory -n "__fish_is_first_arg" -r -a "(__fish_complete_directories)" -d 'Specify playground directory'
complete -c nethack -s n -d 'Do not print news'
complete -c nethack -s p -x -a "(__fish_complete_nethack roles)" -d 'Specify profession'
complete -c nethack -s r -x -a "(__fish_complete_nethack races)" -d 'Specify race'
complete -c nethack -s u -x -a "(__fish_complete_nethack_saves)" -d 'Specify player name'
complete -c nethack -s D -d 'Start in debug/wizard mode'
complete -c nethack -s X -d 'Start in explore mode'
complete -c nethack -o DECgraphics -d 'Use DEC symbol set'
complete -c nethack -o IBMgraphics -d 'Use IBM symbol set'
complete -c nethack -l showpaths -d "Print NetHack's data dirs"
complete -c nethack -l version -d 'Show version information'
complete -c nethack -l version:copy -d 'Show version info & copy to clipboard'
complete -c nethack -l version:dump -d 'Display internal values'
complete -c nethack -s s -l scores -a "(__fish_complete_nethack_scores)" -d 'Print the list of your scores'
complete -c nethack -s v -n "__fish_seen_argument -s s -l scores" -d 'Print all versions present in the score file'
complete -c nethack -s w -l windowtype -x -a "tty curses X11 Qt"
complete -c nethack -l nethackrc -rF -d 'Use config file'
complete -c nethack -l no-nethackrc -d 'Ignore config file'
complete -c nethack -l help -d 'Print help'

set -e nhdirs
