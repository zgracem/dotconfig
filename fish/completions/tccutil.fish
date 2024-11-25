# NOTE: Uses custom `__fish_complete_macos_bundles` function from:
#   $__fish_config_dir/packages/completion-helpers/functions/__fish_complete_macos_bundles.fish

function __fish_complete_tccutil_services
    set -l file /System/Library/PrivateFrameworks/TCC.framework/Resources/Localizable.loctable
    echo "All"
    echo "Accessibility" # this isn't listed in $file for some reason?
    plutil -p /System/Library/PrivateFrameworks/TCC.framework/Resources/Localizable.loctable \
        | string match -rg '(?<=kTCCService)(\w+)' \
        | sort -u
end
set -l tccutil_services (__fish_complete_tccutil_services)
functions -e __fish_complete_tccutil_services

complete -c tccutil -e
complete -c tccutil -n __fish_use_subcommand -x -a reset -d "Reset all decisions"
complete -c tccutil -n '__fish_seen_subcommand_from reset; and __fish_is_nth_token 2' -x -a "$tccutil_services"
complete -c tccutil -n "__fish_seen_subcommand_from $tccutil_services; and __fish_is_nth_token 3" -x -a '(__fish_complete_macos_bundles)'
