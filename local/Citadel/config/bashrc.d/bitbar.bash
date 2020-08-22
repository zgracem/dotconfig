# If BitBar is set to open at login, it will launch too early to read the value
# of RUBYLIB from ~/.config/environment.d, and my menu items will throw
# LoadErrors trying to find my personal stdlib.
killall -s BitBar &>/dev/null || open -a BitBar
