# <https://github.com/SteamRE/DepotDownloader>
function download_depot
    argparse -i -x{n,d},h h/help n/dry-run d/dir= o/os= -- $argv
    or return

    set -l dll
    set -l dir
    if is-cygwin
        set dll $USERPROFILE/Applications/depotdownloader-2.4.5/DepotDownloader.dll
        set dir $USERPROFILE/Downloads
    else if is-macos
        set dll $HOME/opt/stow/depotdownloader-2.4.5/bin/DepotDownloader.dll
        set dir $HOME/Downloads
    else
        echo >&2 "not set up for this platform!"
        return 1
    end

    set -l flags
    set -q _flag_dry_run; and set -a flags -manifest-only
    set -q _flag_dir; and set dir $_flag_dir

    if set -q _flag_os
        switch $_flag_os
            case windows macos linux
                set -a flags -os $_flag_os
            case "*"
                echo >&2 "invalid OS: $_flag_os"
                return 1
        end
    end

    if set -q _flag_help
        _download_depot_usage
        return 0
    else if test (count $argv) -lt 2
        _download_depot_usage
        return 1
    else
        set -l app $argv[1]
        set -l depot $argv[2]

        # if not given, defaults to current
        set -q argv[3]; and set -p flags -manifest $argv[3]

        set -l steam_username (_steam_logged_in_user); or return
        dotnet $dll -dir $dir -username $steam_username \
            -app $app -depot $depot $flags $argv[4..]
    end
end

function _download_depot_usage
    set -l hed (set_color --underline)
    set -l opt (set_color --dim)
    set -l cmd (set_color $fish_color_command)
    set -l arg (set_color --italics brwhite)
    set -l var (set_color $fish_color_operator)
    set -l off (set_color normal)

    set -l opts dry-run dir=PATH
    printf "%sUsage:%s %sdownload_depot%s" $hed $off $cmd $off
    printf " $opt"'['"--%s]$off" $opts
    printf " [$arg%s$off]" {app,depot,manifest}_id
    printf "\n"

    set -l account_id (_steam_account_id; or echo '$your_steam_id')
    printf " * Get %s from https://steamdb.info/watching/%s\n" $arg"app_id"$off $var"$account_id"$off
    printf " * Get %s from https://steamdb.info/app/%s/depots/\n" $arg"depot_id"$off "$var\$app_id$off"
    printf " * Get %s from https://steamdb.info/depot/%s/\n" $arg"manifest_id"$off "$var\$depot_id$off"
end

function _steam_logged_in_user
    set -l file "$HOME/Library/Application Support/Steam/config/loginusers.vdf"
    string match -rg '^\s+"AccountName"\s+"([^"]+)"$' <$file
end

function _steam_account_id
    set -l file "$HOME/Library/Application Support/Steam/logs/parental_log.txt"
    for line in (tac $file)
        if string match -r '(?<=Account ID:\s)\d+' $line
            return 0
        end
    end
    return 1
end

# download_depot --dry-run 489830 489833 2414608533287116506
