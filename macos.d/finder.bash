# -----------------------------------------------------------------------------
# Finder
# -----------------------------------------------------------------------------

# Show the ~/Library folder
chflags nohidden ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes

# Disable the warning when changing a file extension
defaults write com.apple.Finder FXEnableExtensionChangeWarning -bool false

# Disable the warning before emptying the Trash
defaults write com.apple.Finder WarnOnEmptyTrash -bool false

# Avoid creating .DS_Store files on network & USB volumes
defaults write com.apple.DesktopServices DSDontWriteNetworkStores -bool true
defaults write com.apple.DesktopServices DSDontWriteUSBStores -bool true

# Open new windows in my home directory
defaults write com.apple.Finder NewWindowTarget -string "PfHm" \
&& defaults write com.apple.Finder NewWindowTargetPath -string "file://localhost/$HOME"

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Show status bar
defaults write com.apple.Finder ShowStatusBar -bool true

# When performing a search, search the current folder by default
defaults write com.apple.Finder FXDefaultSearchScope -string "SCcf"

# Keep folders on top when sorting by name
if (( MACOS_VERSION >= 12 )); then
  defaults write com.apple.Finder _FXSortFoldersFirst -bool true
fi

# Prefer list view (other view modes: `icnv`, `clmv`, `Flwv`)
defaults write com.apple.Finder FXPreferredViewStyle Nlsv
