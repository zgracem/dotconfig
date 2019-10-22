function reveal --description 'Reveal $1 in Finder/Explorer' -a target
  set -q target; or set target (pwd)

  switch (uname -s)
    case 'Darwin'
      open -R $target
    case 'CYGWIN*'
      set -l windir (cygpath --windir)
      "$windir/explorer" /select, (cygpath -w $target)
    case '*'
      echo >&2 "not available on this system"
      return 1
  end
end
