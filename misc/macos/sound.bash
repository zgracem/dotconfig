# -----------------------------------------------------------------------------
# Sound
# -----------------------------------------------------------------------------

# Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# Disable UI sounds
defaults write com.apple.SystemSound com.apple.sound.uiaudio.enabled -bool false

# Disable feedback sound when changing volume
defaults write -g com.apple.sound.beep.feedback -bool false

# Disable Finder sounds
defaults write com.apple.Finder FinderSounds -bool false
