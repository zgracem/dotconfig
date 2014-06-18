# -----------------------------------------------------------------------------
# ~zozo/.config/homebrew/brew.bash                  Homebrew maintenance script
# say hello: printf "zozo\x40inescapable\x2eorg"
# -----------------------------------------------------------------------------

# abort if Homebrew isn't installed
builtin type -P brew &>/dev/null || return

# fetch the newest version of Homebrew and all formulae from GitHub
brew update

# upgrade outdated, unpinned brews
brew upgrade

# remove old versions from the cellar and clear the cache
brew cleanup -s

# prune dead formulae and ensure all taps are properly linked
brew tap --repair

# remove dead symlinks
brew prune

# check system for potential problems
brew doctor
