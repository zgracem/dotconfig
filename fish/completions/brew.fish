# fish completions for brew external commands

complete -c brew -n __fish_use_subcommand -a bundle -d "Bundler for non-Ruby dependencies"
complete -c brew -n __fish_use_subcommand -a services -d "Manage background services"

# zgracem/caveats
complete -c brew -n __fish_use_subcommand -a caveats -d "Show existing caveats for a formula"

# homebrew/command-not-found
complete -c brew -n __fish_use_subcommand -a command-not-found-init -d "Print setup instructions"

# brew which-formula
complete -c brew -n __fish_use_subcommand -a which-formula -d "Print the formula(e) which provides COMMAND"
complete -c brew -l explain -n '__fish_seen_subcommand_from which-formula' -d "Explain how to get COMMAND"

# brew which-update
complete -c brew -n __fish_use_subcommand -a which-update -d "Update which-formula database"
complate -c brew -l stats -d "Print statistics about the database" -n "__fish_seen_subcommand_from which-update"
complate -c brew -l commit -d "Commit changes using git" -n "__fish_seen_subcommand_from which-update"
complate -c brew -l update-existing -d "Update outdated formulae" -n "__fish_seen_subcommand_from which-update"
complate -c brew -l install-missing -d "Install and update missing formulae" -n "__fish_seen_subcommand_from which-update"
complate -c brew -l max-downloads -x -d "Maximum formulae to download and update" -n "__fish_seen_subcommand_from which-update"

# `brew env` (~/bin/shims/brew-env)
complete -c brew -n __fish_use_subcommand -a env -d "Print all HOMEBREW_* vars"
