-- This script runs as a Folder Action, and opens the folder whenever new items
-- are added, unless it's already open.
--
-- It receives Çthis_folderÈ as an alias, and Çadded_itemsÈ as an alias list.
on adding folder items to this_folder after receiving added_items
	try
		tell application "Finder"
			set open_windows to the target of every Finder window as alias list
			if this_folder is not in the open_windows then
				open this_folder
				reveal the added_items
				activate
			end if
		end tell
	end try
end adding folder items to
