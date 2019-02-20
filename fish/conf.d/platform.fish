function "macos?"
  uname -s | string match -eq "Darwin"
end

function "cygwin?"
  uname -s | string match -eq "CYGWIN"
end
