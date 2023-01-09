#!/usr/bin/env osascript
-- ----------------------------------------------------------------------------
-- Open "Create new address" window under "Hide My Email" with iCloud+
-- Source: https://gist.github.com/AkdM/dcad6ef973c1d4574af803a9a214c6f5
-- ----------------------------------------------------------------------------
-- Kill System Preferences first if already open
if application "System Preferences" is running then
	tell application "System Events"
		set theID to unix id of processes whose name is "System Preferences"
		try
			do shell script "kill -9 " & theID
			delay 0.1
		end try
	end tell
end if

try
	tell application "System Preferences"
		activate
		set the current pane to pane id "com.apple.preferences.AppleIDPrefPane"
		tell application "System Events"
			repeat until window "Apple ID" of application process "System Preferences" exists
			end repeat
			set theWindow to window "Apple ID" of application process "System Preferences"

			-- Select iCloud
			repeat until row 6 of table 1 of scroll area 1 of theWindow exists
			end repeat
			select row 6 of table 1 of scroll area 1 of theWindow

			-- Right part of the window
			set rowDetails to group 1 of theWindow

			repeat until row 4 of table 1 of scroll area 1 of rowDetails
			end repeat

			-- Select the "Hide my Email" row
			set hideMyEmailRow to row 4 of table 1 of scroll area 1 of rowDetails

			repeat until button of UI element 1 of hideMyEmailRow exists
			end repeat

			click button of UI element 1 of hideMyEmailRow

			-- log "Clicked at: " & (value of static text 1 of UI element 1 of hideMyEmailRow)

			-- New opened window, which is a sheet
			set hideMyEmailSheet to sheet 1 of theWindow

			-- Wait for the busy indicator to appear
			repeat until busy indicator 1 of hideMyEmailSheet exists
			end repeat

			-- Then wait for it to disappear
			repeat until (not (busy indicator 1 of hideMyEmailSheet exists))
			end repeat

			set sheet1 to sheet 1 of theWindow
			set addButton to button 1 of group 1 of group 1 of group 1 of UI element 1 of scroll area 1 of sheet1
			click addButton
		end tell
		-- log "End"
	end tell
on error errMsg
	log "ERR: " & errMsg
end try
