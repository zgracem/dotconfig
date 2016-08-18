# -----------------------------------------------------------------------------
# Messages
# -----------------------------------------------------------------------------

# disable automatic emoji and smart quotes
defaults write com.apple.MessagesHelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false
defaults write com.apple.MessagesHelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false

# disable continuous spell checking
defaults write com.apple.MessagesHelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false
