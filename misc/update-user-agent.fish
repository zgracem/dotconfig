#!/usr/bin/env fish

# Execute this script to rebuild configuration files for utilities that spoof
# their user-agent string, based on the current version of Google Chrome.

function generate-user-agent
  set -l fallback_user_agent 'Mozilla/2.02E (Win95; U)'
  set -l system_id
  set -l chrome_path
  set -l chrome_version

  switch (uname -s)
  case 'Darwin'
    set -l macos_version (sw_vers -productVersion | string replace -a . _)
    set system_id "Macintosh; Intel Mac OS X $macos_version"
    set chrome_path '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'
  case 'CYGWIN*' 'MSYS*'
    set -l win_version (uname -s | string replace -rf '.*_NT-([\d.]+).*' '$1')
    set system_id "Windows NT $win_version; Win64; x64"
    set -l chrome_paths 'C:\\Program Files (x86)' "C:\\Users\\$USER\\AppData\\Local"
    for p in $chrome_paths
      set chrome_path "$p\\Google\\Chrome\\Application\\chrome.exe"
      if test -e (cygpath -au "$chrome_path")
        break
      else
        set --erase chrome_path
      end
    end
  case 'Linux' '*BSD'
    set system_id 'X11; '(uname -s)' '(uname -m)
    set chrome_path '/usr/bin/chromium-browser'
  end

  set -l webkit_version 537.36
  set -l format "Mozilla/5.0 ($system_id) AppleWebKit/$webkit_version (KHTML, like Gecko) Chrome/%s Safari/$webkit_version"

  if command -sq wmic; and test -n "$chrome_path"
    set chrome_path (string replace -a '\\' '\\\\' "$chrome_path")
    set chrome_version (wmic datafile where "name=\"$chrome_path\"" get Version /value)
  else if test -x "$chrome_path"
    set -l cmd (string escape -- $chrome_path)
    set chrome_version (eval "$cmd --version")
  end

  if test -n "$chrome_version"
    set chrome_version (string replace -rf '.*?([\d.]+).*' '$1' $chrome_version)
    printf $format $chrome_version
  else
    printf $fallback_user_agent
  end
end

if test "$argv[1]" = "test"
  generate-user-agent
  exit
else
  set files curlrc wgetrc youtube-dl
  touch $XDG_CONFIG_HOME/.src/$files.m4
  cd $XDG_CONFIG_HOME
  and make USER_AGENT=(generate-user-agent) user-agent
end
