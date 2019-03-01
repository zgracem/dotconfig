if in-path exa
  function ll --wraps exa --description 'List files vertically, info-heavy'
    ls --long --time-style=long-iso $argv
  end
else
  function ll --wraps ls --description 'List files vertically, info-heavy'
    set params -l -h
    #           │  └─ human-readable sizes
    #           └──── long-list output

    if [ $COLUMNS -le 100 ]
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
end
