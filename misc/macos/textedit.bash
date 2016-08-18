# -----------------------------------------------------------------------------
# TextEdit
# -----------------------------------------------------------------------------

# use plain text mode for new documents
defaults write -app TextEdit RichText -int 0

# open and save files as UTF-8
defaults write -app TextEdit PlainTextEncoding -int 4
defaults write -app TextEdit PlainTextEncodingForWrite -int 4
