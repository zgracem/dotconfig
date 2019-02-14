# -----------------------------------------------------------------------------
# ls || exa
# -----------------------------------------------------------------------------

functions --erase ls ll lsf

if in-path exa
  alias ls 'exa --all'
  alias ll 'ls --long'
  alias lsf 'll --group --inode --extended'
else
  function ls --description 'List (almost) all files'
    set params -A -q
    #           │  └─ print ? instead of nongraphic characters
    #           └──── list (almost) all files

    if string match "CYGWIN*" (uname -s) >/dev/null
      # append .exe if cygwin magic was needed
      set -a params "--append-exe"
    end

    # colourize output
    if is-gnu ls
      set -a params --color=auto
    else
      set -a params -G
    end

    command ls $params $argv
  end

  function ll --description 'List files vertically, info-heavy'
    set params -l -h
    #           │  └─ human-readable sizes
    #           └──── long-list output

    if test $COLUMNS -le 100
      set -a params -g -o
      #              │  └─ omit owner
      #              └──── omit group
      if is-gnu ls
        # shorter timestamps
        set -a params --time-style='+%y-%m-%d %H:%M'
      end
    end

    ls $params $argv
  end

  function lsf --description 'List files with "full" info'
    set params -A -i -l
    #           │  │  └─ long-list output
    #           │  └──── print inode number
    #           └─────── list (almost) all files

    if test (uname -s) = "Darwin" >/dev/null
      set -a params -@ -O -G
      #              │  │  └─ colourize output
      #              │  └──── print file flags
      #              └─────── display extended attributes
      /bin/ls $params $argv
      return
    else if is-gnu ls
      # colourize output
      set -a params --color=auto
    else
      # colourize output (BSD syntax)
      set -a params -G
    end

    command ls $params $argv
  end
end
