# fish completions for brew external commands
command -q brew; or return

# source builtin completions
set -l brew_comp_file $HOMEBREW_PREFIX/share/fish/vendor_completions.d/brew.fish
path is -f $brew_comp_file; and . $brew_comp_file

# homebrew/command-not-found
complete -c brew -n __fish_use_subcommand -a command-not-found-init -d "Print setup instructions"
# brew which-formula
complete -c brew -n __fish_use_subcommand -a which-formula -d "Print the formula(e) which provides COMMAND"
complete -c brew -l explain -n '__fish_seen_subcommand_from which-formula' -d "Explain how to get COMMAND"
# brew which-update
complete -c brew -n __fish_use_subcommand -a which-update -d "Update which-formula database"
complete -c brew -l stats -d "Print statistics about the database" -n "__fish_seen_subcommand_from which-update"
complete -c brew -l commit -d "Commit changes using git" -n "__fish_seen_subcommand_from which-update"
complete -c brew -l update-existing -d "Update outdated formulae" -n "__fish_seen_subcommand_from which-update"
complete -c brew -l install-missing -d "Install and update missing formulae" -n "__fish_seen_subcommand_from which-update"
complete -c brew -l max-downloads -x -d "Maximum formulae to download and update" -n "__fish_seen_subcommand_from which-update"

# homebrew/aliases
function __fish_brew_complete_aliases
    set -l aliases_dir ~/.brew-aliases
    set -l alias_pattern '^# alias: brew ([a-z0-9-]+)$'
    set -l aliases

    path is -d $aliases_dir; or return

    for file in $aliases_dir/*
        path is -f $file; or continue
        if set -l alias (string match -r -g $alias_pattern <$file)
            set -l actual (string match -r -g '`brew '$alias'` is an alias for `brew ([a-z0-9-]+)`' <$file)
            set -a aliases "$alias"\t"brew $actual"
        end
    end

    if test -n "$aliases"
        printf "%s\n" $aliases
    end
end
__fish_brew_complete_cmd 'alias' 'Show or edit existing aliases'
__fish_brew_complete_arg 'alias' -x -a "(__fish_brew_complete_aliases)"
__fish_brew_complete_arg 'alias' -l edit -x -a "(__fish_brew_complete_aliases)" -d "Open aliases in an editor"
__fish_brew_complete_cmd 'unalias' 'Remove existing aliases'
__fish_brew_complete_arg 'unalias' -x -a "(__fish_brew_complete_aliases)"

# ----------------------------------------------------------------------------
# ~/Developer/Homebrew/homebrew-commands
# ----------------------------------------------------------------------------

# brew caveats
complete -c brew -n __fish_use_subcommand -a caveats -d "Show existing caveats for a formula"
complete -c brew -n "__fish_seen_subcommand_from caveats" -x -a "(__fish_brew_suggest_formulae_all)"

# brew env
function __fish_brew_complete_env
    set --show | string match -r -g '^\$(HOMEBREW_[A-Z_]+):'
end
complete -c brew -n __fish_use_subcommand -a env -d "Print HOMEBREW_* vars"
complete -c brew -n "__fish_seen_subcommand_from env" -x -a "(__fish_brew_complete_env)"

# brew last-update
complete -c brew -n __fish_use_subcommand -a last-update -d "Display date & time of last update"

# brew url
complete -c brew -n __fish_use_subcommand -a url -d "Print homepage URL of a given formula or cask"
complete -c brew -n "__fish_seen_subcommand_from url" -x -a "(__fish_brew_suggest_formulae_all)"
complete -c brew -n "__fish_seen_subcommand_from url" -x -a "(__fish_brew_suggest_casks_all)"

# brew which-command
complete -c brew -n __fish_use_subcommand -a which-command -d "Print the command(s) provided by FORMULA"
complete -c brew -n "__fish_seen_subcommand_from which-command" -x -a "(__fish_brew_suggest_formulae_all)"

# brew cd ($__fish_config_dir/functions/_wrappers/brew.fish)
set -l brew_cd_options "
    cache\t$(brew --cache)
    caskroom\t$(brew --caskroom)
    cellar\t$(brew --cellar)
    prefix\t$(brew --prefix)
    repo\t$(brew --repo)
"
complete -c brew -n __fish_use_subcommand -a cd -d "Change to a Homebrew directory"
complete -c brew -n "__fish_seen_subcommand_from cd" -xa $brew_cd_options
