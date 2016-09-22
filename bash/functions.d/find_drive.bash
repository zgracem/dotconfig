# `find_drive` echoes the path to the root of the volume labeled $1.
# It returns 0 on success and 1 on any kind of failure.

find_drive()
{
  if [[ -n $1 ]]; then
    local label=$1
  else
    scold "Usage: $FUNCNAME LABEL"
    return $EX_USAGE
  fi

  if [[ $OSTYPE =~ cygwin ]]; then
    local caption volname discard
    while read -r caption volname discard; do
      if [[ $volname == $label ]]; then
        caption="${caption,,}"
        echo "/cygdrive/${caption:0:1}"
        return 0
      fi
    done < <(/cygdrive/c/Windows/System32/Wbem/wmic logicaldisk get caption,volumename)

  elif [[ $OSTYPE =~ darwin && -d /Volumes/$label ]]; then
    echo "/Volumes/$label"
    return 0
  fi
  
  scold "volume not found: ${label}"
  return 1
}

# `drive` changes PWD to the volume named $myDrive, if present, and sets the
# environment variable `dir_drive` accordingly before returning 0 on success;
# otherwise, it returns 1.

drive()
{
  if [[ -z $myDrive ]]; then
    scold "\$myDrive not set"
    return 1
  elif [[ ! -d $dir_drive ]]; then
    export dir_drive
    dir_drive=$(find_drive "$myDrive") || return
  fi

  cd "$dir_drive"
}
