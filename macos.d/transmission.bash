# -----------------------------------------------------------------------------
# Transmission
# -----------------------------------------------------------------------------

# Hide the legal disclaimer & donate message
defaults write -app Transmission WarningLegal -bool false
defaults write -app Transmission WarningDonate -bool false
defaults write -app Transmission DonateAskDate -date "2013-07-03 01:36:57 +0000"

# Show filter bar & pieces bar
defaults write -app Transmission FilterBar -bool true
defaults write -app Transmission PiecesBar -bool true

# -----------------------------------------------------------------------------
# General
# -----------------------------------------------------------------------------

# Automatically size window to fit all transfers
defaults write -app Transmission AutoSize -bool true

# Prompt on delete/quit only when transfers are downloading
defaults write -app Transmission CheckQuit -bool true
defaults write -app Transmission CheckQuitDownloading -bool true
defaults write -app Transmission CheckRemove -bool true
defaults write -app Transmission CheckRemoveDownloading -bool true

# -----------------------------------------------------------------------------
# Transfers
# -----------------------------------------------------------------------------

# Adding

# Use `~/Downloads` to store complete & incomplete downloads
defaults write -app Transmission DownloadFolder -string "${HOME}/Downloads"
defaults write -app Transmission DownloadLocationConstant -bool true
defaults write -app Transmission UseIncompleteDownloadFolder -bool true
defaults write -app Transmission IncompleteDownloadFolder -string "${HOME}/Downloads"

# Trash original torrent files
defaults write -app Transmission DeleteOriginalTorrent -bool true

# Don’t prompt for confirmation before downloading
defaults write -app Transmission DownloadAsk -bool false
defaults write -app Transmission MagnetOpenAsk -bool false

# Append `.part` to incomplete files
defaults write -app Transmission RenamePartialFiles -bool true

# Automatically import .torrent files from ~/Downloads
defaults write -app Transmission AutoStartDownload -bool true
defaults write -app Transmission AutoImport -bool true
defaults write -app Transmission AutoImportDirectory -string "${HOME}/Downloads"

# Management

# Set ratio
defaults write -app Transmission RatioCheck -bool true
defaults write -app Transmission RatioLimit -float 0.01

# Stop seeding when inactive
defaults write -app Transmission IdleLimitCheck -bool true
defaults write -app Transmission IdleLimitMinutes -int 5

# Don't use a queue
defaults write -app Transmission Queue -bool false

# When download completes, play a sound and call a script
defaults write -app Transmission DownloadSound -string "Glass"
defaults write -app Transmission DoneScriptEnabled -bool true
defaults write -app Transmission DoneScriptPath -string "${HOME}/scripts/util/tx-cleanup.sh"

# -----------------------------------------------------------------------------
# Bandwidth & Peers
# -----------------------------------------------------------------------------

# Global bandwidth limits (in KB/s)
defaults write -app Transmission DownloadLimit -int 128
defaults write -app Transmission UploadLimit -int 64
defaults write -app Transmission SpeedLimitAuto -bool false
defaults write -app Transmission SpeedLimitDownloadLimit -int 256
defaults write -app Transmission SpeedLimitUploadLimit -int 32

# Global maximum connections
defaults write -app Transmission PeersTotal -int 100
# Max. connections for new transfers
defaults write -app Transmission PeersTorrent -int 50

# Use peer exchange/PEX, distributed hash table/DHT, and local peer discovery
defaults write -app Transmission PEXGlobal -bool true
defaults write -app Transmission DHTGlobal -bool true
defaults write -app Transmission LocalPeerDiscoveryGlobal -bool true

# Prefer encrypted peers, but don't ignore unencrypted ones
defaults write -app Transmission EncryptionPrefer -bool true
defaults write -app Transmission EncryptionRequire -bool false

# IP block list.
# >> https://giuliomac.wordpress.com/2014/02/19/best-blocklist-for-transmission/
defaults write -app Transmission BlocklistNew -bool true
defaults write -app Transmission BlocklistURL -string "http://john.bitsurge.net/public/biglist.p2p.gz"
defaults write -app Transmission BlocklistAutoUpdate -bool true

# -----------------------------------------------------------------------------
# Network
# -----------------------------------------------------------------------------

# Enable Micro Transport Protocol (µTP)
defaults write -app Transmission UTPGlobal -bool true

# Use port 59192
defaults write -app Transmission BindPort -int 59192

# Automatically map port w/ NAT traversal
defaults write -app Transmission NatTraversal -bool true

# Prevent computer from sleeping w/ active transfers
defaults write -app Transmission PreventSleep -bool true
