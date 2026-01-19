# fish_versinfo splits fish's $version into an array like $BASH_VERSINFO.
#
# Released fish versions are in the format `X.Y.Z` (even X.0.0 and X.Y.0).
#
# Dev builds look like `X.Y.Z-A-gH`, where `X.Y.Z` is the last release,
# `A` is the count of commits since x.y.z, `g` is literally the letter g,
# and `H` is the shortened hash of the latest git commit (which we discard).
#
# Beta releases look like `X.YbB`, where uppercase B is the beta number,
# and post-beta dev versions look like `X.YbB-A-gH`.
#
# See also $__fish_config_dir/conf.d/fish_versinfo.fish
function fish_versinfo -a fish_ver
    set -q fish_ver[1]; or set -f fish_ver $version
    set -f version_info (string split "." $fish_ver | string split "-")

    # Discard git commit hash (which can't be easily compared)
    string match -q "g*" $version_info[5]
    and set --erase version_info[5]

    # The following allows for usage like `fish-is-newer-than 3.1`
    # (i.e. without the trailing `.0`) and for comparing releases to
    # beta and development builds.
    set -q version_info[2]; or set version_info[2] 0   # Y
    set -q version_info[3]; or set version_info[3] 0   # Z
    set -q version_info[4]; or set version_info[4] 0   # A
    set -q version_info[5]; or set version_info[5] 1.0 # B

    # Special handling for beta releases (`X.YbB` or `X.YbB-A-gH`)
    if string match -rq '^(?<minor>\d+)b(?<beta>\d+)$' $version_info[2]
        set version_info[5] "0.$beta"        # B
        set version_info[4] $version_info[3] # A
        set version_info[3] 0                # Z
        set version_info[2] $minor           # Y
    end

    string join \n $version_info
end
