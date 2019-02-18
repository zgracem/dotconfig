function "macos?"
  test (uname -s) = "Darwin"
end

function "cygwin?"
  uname -s | grep -q "CYGWIN"
end
