function is-macos --description 'Returns true if running on macOS'
  uname -s | string match -eq 'Darwin'
end

function is-cygwin --description 'Returns true if running on Cygwin'
  uname -s | string match -eq 'CYGWIN'
end

function is-linux --description 'Returns true if running on Linux'
  uname -s | string match -eq 'Linux'
end

function is-wsl --description 'Returns true if running on Windows Subsystem for Linux'
  uname -r | string match -eq 'Microsoft'
end
