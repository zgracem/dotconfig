# -----------------------------------------------------------------------------
# Localization
# -----------------------------------------------------------------------------

declare -A datefmt=() timefmt=()

datefmt[short]="d/M/yy"
datefmt[medium]="yyyy-MM-dd"
datefmt[long]="d MMMM y"
datefmt[full]="EEEE, d MMMM yyyy"

timefmt[short]="HH:mm"
timefmt[medium]="HH:mm:ss"
timefmt[long]="HH:mm:ss z"
timefmt[full]="HH:mm:ss Z"

# time zone
TZ=America/Edmonton

# -----------------------------------------------------------------------------

# Time zone (see `systemsetup -listtimezones` for other values)
sudo systemsetup -settimezone "$TZ" &>/dev/null

# Locale
defaults write -g AppleLanguages "(en-CA, en-GB, en)"
defaults write -g AppleLocale -string "en_CA@currency=CAD"
defaults write -g NSPreferredSpellServerLanguage -string "en_CA"

# Date formats
defaults write -g AppleICUDateFormatStrings -dict-add "1" "${datefmt[short]}"
defaults write -g AppleICUDateFormatStrings -dict-add "2" "${datefmt[medium]}"
defaults write -g AppleICUDateFormatStrings -dict-add "3" "${datefmt[long]}"
defaults write -g AppleICUDateFormatStrings -dict-add "4" "${datefmt[full]}"

# 24-hour clocks
defaults write -g AppleICUTimeFormatStrings -dict-add "1" "${timefmt[short]}"
defaults write -g AppleICUTimeFormatStrings -dict-add "2" "${timefmt[medium]}"
defaults write -g AppleICUTimeFormatStrings -dict-add "3" "${timefmt[long]}"
defaults write -g AppleICUTimeFormatStrings -dict-add "4" "${timefmt[full]}"
defaults write com.apple.menuextra.clock DateFormat -string "${timefmt[short]}"

# Same in system preferences
defaults write com.apple.systempreferences AppleIntlCustomFormat -dict-add \
    "AppleIntlCustomICUDictionary" \
    "{'AppleICUDateFormatStrings'={'1'='${datefmt[short]}';'2'='${datefmt[medium]}';'3'='${datefmt[long]}';'4'='${datefmt[full]}';};'AppleICUTimeFormatStrings'={'1'='${timefmt[short]}';'2'='${timefmt[medium]}';'3'='${timefmt[long]}';'4'='${timefmt[full]}';};};'AppleIntlCustomLocale'='en_CA';}"

# Use imperial measurements
defaults write -g AppleMeasurementUnits -string "Inches"
defaults write -g AppleMetricUnits -bool false

