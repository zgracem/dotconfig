function is-macos --description 'Returns true if running on macOS'
    uname -s | string match -q "Darwin"
end

function is-cygwin --description 'Returns true if running on Cygwin'
    uname -s | string match -q "CYGWIN*"
end

function is-linux --description 'Returns true if running on Linux'
    uname -s | string match -q "Linux"
end

function is-wsl --description 'Returns true if running on Windows Subsystem for Linux'
    uname -s | string match -q "Microsoft"
end

function is-deck --description 'Returns true if running on SteamOS'
    uname -r | string match -q "*-valve*"
end

function is-raspi --description 'Returns true if running on a Raspberry Pi'
    uname -r | string match -q "*-rpi*"
end
