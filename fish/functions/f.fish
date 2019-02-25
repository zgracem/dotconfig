# Defined in /home/uxhj/var/run/fish/fish.5zqrdG/f.fish @ line 1
function f --description 'Open a Finder/Explorer window for $PWD/$1'
	set -q argv[1]; or set argv[1] (pwd)

  switch (uname -s)
    case 'Darwin'
      open -a Finder $argv[1]
    case 'CYGWIN*'
      set -l windir (cygpath --windir)
      "$windir/explorer" (cygpath -w $argv[1])
    case '*'
      echo >&2 "not available on this system"
      return 1
  end
end
