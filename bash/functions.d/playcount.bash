_inPath osascript || return

playcount()
{	#: - set the play count of the selected item(s) in iTunes to $1
  #: * this function is extremely fragile!

	local ct=$1
	osascript <<-EOT
		tell application "iTunes"
			if selection is not {} then
				set sel to selection
				repeat with t in sel
					set t to contents of t
					set played count of t to (${ct} as integer)
					if (${ct} as integer) is 0 then
						try
							set played date of t to missing value
						end try
					end if
				end repeat
			end if
		end tell
	EOT
}
