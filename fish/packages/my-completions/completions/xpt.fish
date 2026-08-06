set -l xpt_file_cmds upload upload-font
set -l xpt_settings_keys \
    autoBackupStats bionicReadingEnabled clockFormat clockHasBeenSynced \
    clockUtcOffsetQ deviceName embeddedStyle extraParagraphSpacing fadingFix \
    fileBrowserDisplay fontFamily fontSize forceParagraphIndents \
    frontButtonOrientationAware guideReadingEnabled hideBatteryPercentage \
    hideClock hideFileExtension hyphenationEnabled imageRendering \
    koMatchMethod koPassword koServerUrl koUsername lineHeightPercent \
    longPressBackAction longPressButtonBehavior longPressMenuAction longPwrBtn \
    moveFinishedToReadFolder orientation paragraphAlignment publisherPageNumbers \
    pwrBtnFootnoteBack quickResumeSleepScreen readerDarkMode \
    readingIdleTimeThresholdUnits recentBooksView refreshFrequency \
    removeReadBooksFromRecents screenMargin sdFontSizeRange shortPwrBtn \
    showHiddenFiles sideButtonLayout sideButtonLongPress \
    sideButtonOrientationAware sleepScreen sleepScreenCoverFilter \
    sleepScreenCoverMode sleepTimeoutMinutes stablePageNumbers \
    statusBarBattery statusBarBookProgressPercentage statusBarChapterPageCount \
    statusBarProgressBar statusBarProgressBarThickness statusBarTimeLeft \
    statusBarTitle textAntiAliasing uiTheme xtcStatusBarMode

complete -c xpt -n "__fish_is_nth_token 1" -x -a '(xpt -h)'
complete -c xpt -n "__fish_seen_subcommand_from $xpt_file_cmds" -rF
complete -c xpt -n "__fish_seen_subcommand_from post-settings" -xa "$xpt_settings_keys"

# '^\s*case (\S+)(?: # (.+))?$'
