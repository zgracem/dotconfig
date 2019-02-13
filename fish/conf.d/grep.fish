# -----------------------------------------------------------------------------
# grep
# -----------------------------------------------------------------------------

function grep
  set params -EsI -d skip -D skip
  #           │││  │       └───── silently skip devices
  #           │││  └───────────── silently skip directories
  #           ││└──────────────── ignore binary files
  #           │└───────────────── no errors about missing/unreadable files
  #           └────────────────── use ERE syntax

  # display results in colour if supported
  set -a params --colour=auto

  # skip version control directories
  set -a params --exclude-dir=.git --exclude-dir=.svn

  command grep $params $argv
end

function g --wraps grep --description 'Search files in PWD'
  grep --line-number $argv -- ./*
end

function gg --wraps grep --description 'Search files and directories in PWD'
  g --recursive $argv
end
