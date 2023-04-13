-- This script gets compiled to an application that runs as a login item, which
-- hangs around in the background until the user logs out.
-- See Makefile `WaitForLogout.mk` for more setup details.
-- Source: https://apple.stackexchange.com/a/345818

-- (optional)
-- do shell script "~/.config/macos/login.sh"

on quit
	do shell script "~/.config/macos/logout.sh"
	continue quit
end quit
