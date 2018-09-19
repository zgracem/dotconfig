# -----------------------------------------------------------------------------
# Finder
# -----------------------------------------------------------------------------

# Show the ~/Library folder
chflags nohidden ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes

# Enable AirDrop over Ethernet and on unsupported Macs running Lion
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

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

# # Show all filename extensions
# defaults write -g AppleShowAllExtensions -bool true

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Path bar shows relative to $HOME
defaults write com.apple.Finder PathBarRootAtHome -bool TRUE

# Show status bar
defaults write com.apple.Finder ShowStatusBar -bool true

# When performing a search, search the current folder by default
defaults write com.apple.Finder FXDefaultSearchScope -string "SCcf"

# Allow text selection in QuickLook
if (( MACOS_VERSION < 11 )); then
  defaults write com.apple.Finder QLEnableTextSelection -bool true
fi

# Keep folders on top when sorting by name
if (( MACOS_VERSION >= 12 )); then
  defaults write com.apple.Finder _FXSortFoldersFirst -bool true
fi

# Prefer list view (other view modes: `icnv`, `clmv`, `Flwv`)
defaults write com.apple.Finder FXPreferredViewStyle Nlsv
