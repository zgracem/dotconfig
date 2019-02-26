function "macos?"
  uname -s | string match -eq 'Darwin'
end

function "cygwin?"
  uname -s | string match -eq 'CYGWIN'
end

function "linux?"
  uname -s | string match -eq 'Linux'
end
