# -----------------------------------------------------------------------------
# Transmission
# -----------------------------------------------------------------------------

# Use `~/Downloads` to store incomplete downloads
defaults write -app Transmission UseIncompleteDownloadFolder -bool true
defaults write -app Transmission IncompleteDownloadFolder -string "${HOME}/Downloads"

# Don’t prompt for confirmation before downloading
defaults write -app Transmission DownloadAsk -bool false
defaults write -app Transmission MagnetOpenAsk -bool false

# Trash original torrent files
defaults write -app Transmission DeleteOriginalTorrent -bool true

# Hide the donate message
defaults write -app Transmission WarningDonate -bool false
defaults write -app Transmission DonateAskDate -date "2013-07-03 01:36:57 +0000"

# Hide the legal disclaimer
defaults write -app Transmission WarningLegal -bool false

# Set ratio
defaults write -app Transmission RatioCheck -bool true
defaults write -app Transmission RatioLimit -float 0.01

# Use port 59192
defaults write -app Transmission BindPort -int 59192

# IP block list.
# >> https://giuliomac.wordpress.com/2014/02/19/best-blocklist-for-transmission/
defaults write -app Transmission BlocklistNew -bool true
defaults write -app Transmission BlocklistURL -string "http://john.bitsurge.net/public/biglist.p2p.gz"
defaults write -app Transmission BlocklistAutoUpdate -bool true
