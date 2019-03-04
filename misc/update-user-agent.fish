#!/usr/bin/env fish

# Execute this script to rebuild configuration files for utilities that spoof
# their user-agent string, based on the current version of Google Chrome.

function generate-user-agent
  set -l system_id
  set -l chrome_path
  set -l chrome_version

  switch (uname -s)
  case 'Darwin'
    set -l macos_version (sw_vers -productVersion | string replace -a . _)
    set system_id "Macintosh; Intel Mac OS X $macos_version"
    set chrome_path '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'
  case 'CYGWIN*'
    set -l win_version (uname -s | string replace -rf 'CYGWIN_NT-([\d.]+).*' '$1')
    set system_id "Windows NT $win_version; Win64; x64"
    set chrome_path 'C:\Program Files (x86)\Google\Chrome\Application\chrome.exe'
  case 'Linux'
    set system_id 'X11; '(uname -s)' '(uname -m)
    set chrome_path '/usr/bin/chromium-browser'
  end

  set -l webkit_version 537.36
  set -l format "Mozilla/5.0 ($system_id) AppleWebKit/$webkit_version (KHTML, like Gecko) Chrome/%s Safari/$webkit_version"

  if command -sq wmic
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
    printf 'Mozilla/2.02E (Win95; U)'
  end
end

# generate-user-agent; exit

set files curlrc wgetrc youtube-dl

touch $XDG_CONFIG_HOME/.src/$files.m4

make USER_AGENT=(generate-user-agent) user-agent
