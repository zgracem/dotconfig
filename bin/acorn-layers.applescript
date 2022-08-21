#!/usr/bin/env osascript

on run argv
	set filePath to (item 1 of argv)
	if filePath does not start with "/"
		set currentDir to the POSIX path of (POSIX file (do shell script "pwd"))
		set filePath to currentDir & "/" & (item 1 of argv)
	end if
	set theFile to POSIX file filePath as alias

	set verbosePreference to false

	tell application "Acorn"
		open theFile
		tell application "System Events" to tell process "Acorn" to set visible to false
		set acornDocument to document 1
		set layerNames to my list_layers(acornDocument, verbosePreference)
		close acornDocument
	end tell

	set AppleScript's text item delimiters to linefeed
	set theString to layerNames as string
	set AppleScript's text item delimiters to ""

	return theString
end run

on list_layers(acornDocument, verbosity)
	set allLayerNames to {}

	tell application "Acorn"
		repeat with b in bitmap layers in acornDocument
			set layerName to the name of b
			if verbosity is true then set layerName to layerName & " [bitmap]"
			set the end of allLayerNames to layerName
		end repeat

		repeat with s in shape layers in acornDocument
			set layerName to the name of s
			if verbosity is true then set layerName to layerName & " [shape]"
			set the end of allLayerNames to layerName
		end repeat

		repeat with g in group layers in acornDocument
			set layerName to the name of g
			if verbosity is true then set layerName to layerName & " [group]"
			if verbosity is true then set the end of allLayerNames to layerName

			set groupedLayerNames to my list_layers(g, verbosity)
			repeat with l in groupedLayerNames
				set layerName to l as string
				if verbosity is true then set layerName to the name of g & "/" & layerName
				set the end of allLayerNames to layerName
			end repeat
		end repeat
	end tell

	return allLayerNames
end list_layers
