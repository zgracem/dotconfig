# -----------------------------------------------------------------------------
# Spotlight
# -----------------------------------------------------------------------------

# Disable Spotlight indexing for new unindexed volumes.
# Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing any volume.
sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"

if (( MACOS_VERSION >= 10 )); then
  defaults write com.apple.spotlight orderedItems -array \
    '{ enabled = 1; name = "APPLICATIONS"; }' \
    '{ enabled = 1; name = "MENU_SPOTLIGHT_SUGGESTIONS"; }' \
    '{ enabled = 1; name = "MENU_CONVERSION"; }' \
    '{ enabled = 1; name = "MENU_EXPRESSION"; }' \
    '{ enabled = 1; name = "MENU_DEFINITION"; }' \
    '{ enabled = 1; name = "SYSTEM_PREFS"; }' \
    '{ enabled = 1; name = "DOCUMENTS"; }' \
    '{ enabled = 1; name = "DIRECTORIES"; }' \
    '{ enabled = 1; name = "PRESENTATIONS"; }' \
    '{ enabled = 1; name = "SPREADSHEETS"; }' \
    '{ enabled = 1; name = "PDF"; }' \
    '{ enabled = 1; name = "MESSAGES"; }' \
    '{ enabled = 1; name = "CONTACT"; }' \
    '{ enabled = 1; name = "EVENT_TODO"; }' \
    '{ enabled = 1; name = "IMAGES"; }' \
    '{ enabled = 1; name = "BOOKMARKS"; }' \
    '{ enabled = 1; name = "MUSIC"; }' \
    '{ enabled = 1; name = "MOVIES"; }' \
    '{ enabled = 1; name = "FONTS"; }' \
    '{ enabled = 1; name = "MENU_OTHER"; }' \
    '{ enabled = 0; name = "MENU_WEBSEARCH"; }' \
    '{ enabled = 1; name = "SOURCE"; }'
else
  defaults write com.apple.spotlight orderedItems -array \
    '{ enabled = 1; name = "APPLICATIONS"; }' \
    '{ enabled = 1; name = "SYSTEM_PREFS"; }' \
    '{ enabled = 1; name = "DOCUMENTS"; }' \
    '{ enabled = 1; name = "DIRECTORIES"; }' \
    '{ enabled = 1; name = "PRESENTATIONS"; }' \
    '{ enabled = 1; name = "SPREADSHEETS"; }' \
    '{ enabled = 1; name = "PDF"; }' \
    '{ enabled = 1; name = "MESSAGES"; }' \
    '{ enabled = 1; name = "CONTACT"; }' \
    '{ enabled = 1; name = "EVENT_TODO"; }' \
    '{ enabled = 1; name = "IMAGES"; }' \
    '{ enabled = 1; name = "BOOKMARKS"; }' \
    '{ enabled = 1; name = "MUSIC"; }' \
    '{ enabled = 1; name = "MOVIES"; }' \
    '{ enabled = 1; name = "FONTS"; }' \
    '{ enabled = 1; name = "SOURCE"; }'
fi
