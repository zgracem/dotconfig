# -----------------------------------------------------------------------------
# Safari & WebKit
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Privacy & security
# -----------------------------------------------------------------------------

# Privacy: don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Prevent Safari from opening ‘safe’ files automatically after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Warn about fraudulent websites
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true

# Disable Java
defaults write com.apple.Safari WebKitJavaEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool false

# Block pop-up windows
defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false

# Enable “Do Not Track”
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

# Update extensions automatically
defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true

# -----------------------------------------------------------------------------
# Dev tools
# -----------------------------------------------------------------------------

# Enable the Debug & Develop menus and the Web Inspector
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# # Add a context menu item for showing the Web Inspector in web views
# defaults write -g WebKitDeveloperExtras -bool true

# -----------------------------------------------------------------------------
# Appearance & behaviour
# -----------------------------------------------------------------------------

# Make Safari's search banners default to Contains instead of Starts With
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

# Show the full URL in the address bar (note: this still hides the scheme)
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Remove useless icons from Safari's bookmarks bar
defaults write com.apple.Safari ProxiesInBookmarksBar "()"

# Hide Safari’s sidebar in Top Sites
defaults write com.apple.Safari ShowSidebarInTopSites -bool false

# Enable continuous spellchecking
defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true
# Disable auto-correct
defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false

# # Fixed-width fonts
# defaults write com.apple.Safari Safari.ContentPageGroupIdentifier.WebKit2FixedFontFamily Monaco
# defaults write com.apple.Safari Safari.ContentPageGroupIdentifier.WebKit2DefaultFixedFontSize 11

# # Proportional fonts
# defaults write com.apple.Safari Safari.ContentPageGroupIdentifier.WebKit2StandardFontFamily 'Helvetica Neue'
# defaults write com.apple.Safari Safari.ContentPageGroupIdentifier.WebKit2DefaultFontSize 14
