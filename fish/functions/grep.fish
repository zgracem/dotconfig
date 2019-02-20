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
