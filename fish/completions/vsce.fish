function __fish_complete_vsce_subcmds
    set -l subcmds \
        "ls,List all files that will be published" \
        "package,Package an extension" \
        "publish,Publish an extension" \
        "unpublish,Unpublish an extension" \
        "ls-publishers,List known publishers" \
        "delete-publisher,Delete a publisher" \
        "login,Add a known publisher" \
        "logout,Remove a known publisher" \
        "verify-pat,Verify Personal Access Token" \
        "show,Show extension metadata" \
        "search,Search extension gallery" \
        "help,Display help for command"

    string replace , \t $subcmds
end

function __fish_complete_vsce_help
    __fish_complete_vsce_subcmds | string split \t -f1 | string match -v help
end

function __fish_complete_vsce_publishers
    if not set -gq __vsce_publishers
        set -g __vsce_publishers (vsce ls-publishers)
    end

    echo -ns $__vsce_publishers\t"(Publisher)"\n
end

set -l __vsce_target_arch \
    win32-x64 win32-ia32 win32-arm64 linux-x64 linux-arm64 linux-armhf \
    darwin-x64 darwin-arm64 alpine-x64 alpine-arm64 web

# Usage: vsce <command> [options]
complete -c vsce --no-files
complete -c vsce -xa "(__fish_complete_vsce_subcmds)" -n __fish_is_first_arg
complete -c vsce -s V -l version -d "Output the version number" -n __fish_is_first_arg

# Common options
complete -c vsce -s h -l help -d "Display help"
complete -c vsce -l yarn -d "Use yarn instead of npm" -n "__fish_seen_subcommand_from ls package publish; and not __fish_seen_argument -l no-yarn"
complete -c vsce -l no-yarn -d "Use npm instead of yarn" -n "__fish_seen_subcommand_from ls package publish; and not __fish_seen_argument -l yarn"
complete -c vsce -l ignoreFile -rF -d "Alt path to .vscodeignore" -n "__fish_seen_subcommand_from ls package publish"

# Usage: vsce ls [options]
complete -c vsce -l packagedDependencies -rF -d "Publish only these packages" -n "__fish_seen_subcommand_from ls"

# Usage: vsce package [options]
complete -c vsce -s o -l out -rF -d "Output .vsix file here" -n "__fish_seen_subcommand_from package"
complete -c vsce -s t -l target -xa "$__vsce_target_arch" -d "Target architecture" -n "__fish_seen_subcommand_from package publish"
complete -c vsce -s m -l message -d "Commit message for `npm version`"  -n "__fish_seen_subcommand_from package publish"
complete -c vsce -l no-git-tag-version -d "Do not create a commit/tag with `npm version`" -n "__fish_seen_subcommand_from package publish"
complete -c vsce -l no-update-package-json -d "Do not update package.json" -n "__fish_seen_subcommand_from package publish" #  Valid only when [version] is provided
complete -c vsce -l githubBranch -x -d "Base GitHub branch for relative links in README" -n "__fish_seen_subcommand_from package publish; and not __fish_seen_argument -l baseContentUrl -l baseImagesUrl -l gitlabBranch"
complete -c vsce -l gitlabBranch -x -d "Base GitLab branch for relative links in README" -n "__fish_seen_subcommand_from package publish; and not __fish_seen_argument -l baseContentUrl -l baseImagesUrl -l githubBranch"
complete -c vsce -l no-rewrite-relative-links -d "Skip rewriting relative links" -n "__fish_seen_subcommand_from package"
complete -c vsce -l baseContentUrl -x -d "Base URL for relative links in README" -n "__fish_seen_subcommand_from package publish; and not __fish_seen_argument -l githubBranch"
complete -c vsce -l baseImagesUrl -x -d "Base URL for relative images in README" -n "__fish_seen_subcommand_from package publish; and not __fish_seen_argument -l githubBranch"
complete -c vsce -l no-gitHubIssueLinking -d "Do not expand GitHub issues into links" -n "__fish_seen_subcommand_from package; and not __fish_seen_argument -l no-gitLabIssueLinking"
complete -c vsce -l no-gitLabIssueLinking -d "Do not expand GitLab issues into links" -n "__fish_seen_subcommand_from package; and not __fish_seen_argument -l no-gitHubIssueLinking"
complete -c vsce -l dependencies -d "Enable dependency detection" -n "__fish_seen_subcommand_from package publish"
complete -c vsce -l no-dependencies -d "Disable dependency detection" -n "__fish_seen_subcommand_from package publish"
complete -c vsce -l pre-release -d "Mark package as pre-release" -n "__fish_seen_subcommand_from package publish"
complete -c vsce -l allow-star-activation -d "Allow * in activation events" -n "__fish_seen_subcommand_from package publish"
complete -c vsce -l allow-missing-repository -d "Allow missing repo URL in package.json" -n "__fish_seen_subcommand_from package publish"

# Usage: vsce publish [options] [<version>]
complete -c vsce -s p -l pat -x -d "Personal Access Token" -n "__fish_seen_subcommand_from publish unpublish verify-pat"
complete -c vsce -l noVerify -n "__fish_seen_subcommand_from publish"

# Usage: vsce unpublish [options] [<extensionid>]
complete -c vsce -s f -l force -d "Force unpublishing extension" -n "__fish_seen_subcommand_from unpublish"

# Usage: vsce delete-publisher <publisher>
# Usage: vsce login <publisher>
# Usage: vsce logout <publisher>
# Usage: vsce verify-pat [options] [publisher]
complete -c vsce -a "(__fish_complete_vsce_publishers)" -n "__fish_seen_subcommand_from delete-publisher login logout verify-pat"

# Usage: vsce show [options] <extensionid>
complete -c vsce -l json -d "Output data in JSON format" -n "__fish_seen_subcommand_from show search"

# Usage: vsce search [options] <text>
complete -c vsce -l stats -d "Show rating and downloads" -n "__fish_seen_subcommand_from show search"
complete -c vsce -s p -l pagesize -xa 100\t"(default)" -d "Number of results to return" -n "__fish_seen_subcommand_from search"

# Usage: vsce help <command>
complete -c vsce -a "(__fish_complete_vsce_help)" -n "__fish_seen_subcommand_from help"
