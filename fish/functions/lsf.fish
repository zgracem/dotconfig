if in-path exa
  function lsf --wraps exa --description 'List files with "full" info'
    ll --group --inode --extended $argv
  end
else
  function lsf --wraps ls --description 'List files with "full" info'
    set params -A -i -l
    #           │  │  └─ long-list output
    #           │  └──── print inode number
    #           └─────── list (almost) all files

    if is-macos
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
