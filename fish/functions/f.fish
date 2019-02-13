function f --description 'Open a Finder/Explorer window for $PWD/$1'
  switch (uname -s)
    case 'Darwin'
      open -a Finder $argv[1]
    case 'CYGWIN*'
      set -l windir (cygpath --windir)
      "$windir/explorer" (cygpath -w $argv[1])
    case '*'
      echo >&2 "not available on this system"
      return 71
  end
end
