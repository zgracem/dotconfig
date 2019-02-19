function reveal --description 'Reveal $1 in Finder/Explorer'
  test -n "$argv[1]"; or return 1

  switch (uname -s)
    case 'Darwin'
      open -R $argv[1]
    case 'CYGWIN*'
      set -l windir (cygpath --windir)
      "$windir/explorer" /select, (cygpath -w $argv[1])
    case '*'
      echo >&2 "not available on this system"
      return 71
  end
end
