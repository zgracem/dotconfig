function f --description 'Open a Finder/Explorer window for $PWD/$1' -a target
  set -q target; or set target (pwd)

  switch (uname -s)
    case 'Darwin'
      open -a Finder $target
    case 'CYGWIN*'
      set -l windir (cygpath --windir)
      "$windir/explorer" (cygpath -w $target)
    case '*'
      echo >&2 "not available on this system"
      return 1
  end
end
