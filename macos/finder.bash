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

# # Disable quarantine warnings
# defaults write com.apple.LaunchServices LSQuarantine -bool false

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

# Expand the following File Info panes:
#   “General”, “Open with”, and “Sharing & Permissions”
defaults write com.apple.Finder FXInfoPanesExpanded -dict \
  General    -bool true \
  OpenWith   -bool true \
  Privileges -bool true \
  Comments   -bool false \
  MetaData   -bool false \
  Name       -bool false

# When performing a search, search the current folder by default
defaults write com.apple.Finder FXDefaultSearchScope -string "SCcf"

# # Empty Trash securely by default
# defaults write com.apple.Finder EmptyTrashSecurely -bool true

# Allow text selection in QuickLook
if (( MACOS_VERSION < 11 )); then
  defaults write com.apple.Finder QLEnableTextSelection -bool true
fi

# Folder previews in QuickLook
defaults write com.apple.Finder QLEnableXRayFolders -boolean true

# -----------------------------------------------------------------------------

# Prefer list view (other view modes: `icnv`, `clmv`, `Flwv`)
defaults write com.apple.Finder FXPreferredViewStyle Nlsv

declare grid_spacing=93
declare icon_size=64

declare -a settings=()

# Show item info near icons on the desktop and in other icon views
settings+=(":DesktopViewSettings:IconViewSettings:showItemInfo true")
settings+=(":FK_StandardViewSettings:IconViewSettings:showItemInfo true")
settings+=(":StandardViewSettings:IconViewSettings:showItemInfo true")

# Show item info to the right of the icons on the desktop
settings+=("DesktopViewSettings:IconViewSettings:labelOnBottom false")

# Enable snap-to-grid for icons on the desktop and in other icon views
settings+=(":DesktopViewSettings:IconViewSettings:arrangeBy grid")
settings+=(":FK_StandardViewSettings:IconViewSettings:arrangeBy grid")
settings+=(":StandardViewSettings:IconViewSettings:arrangeBy grid")

# Increase grid spacing for icons on the desktop and in other icon views
settings+=(":DesktopViewSettings:IconViewSettings:gridSpacing $grid_spacing")
settings+=(":FK_StandardViewSettings:IconViewSettings:gridSpacing $grid_spacing")
settings+=(":StandardViewSettings:IconViewSettings:gridSpacing $grid_spacing")

# Increase the size of icons on the desktop and in other icon views
settings+=(":DesktopViewSettings:IconViewSettings:iconSize $icon_size")
settings+=(":FK_StandardViewSettings:IconViewSettings:iconSize $icon_size")
settings+=(":StandardViewSettings:IconViewSettings:iconSize $icon_size")

for setting in "${settings[@]}"; do
  /usr/libexec/PlistBuddy -c "Set $setting" ~/Library/Preferences/com.apple.finder.plist
done

unset -v setting settings
