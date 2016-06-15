[[ $OSTYPE =~ cygwin ]] || return

drive()
{
  if [[ -z $myDrive ]]; then
    scold "\$myDrive not set"
    return 1
  elif [[ ! -d $dir_drive ]]; then
    if ! dir_drive=$(findDrive "$myDrive"); then
      scold "'${myDrive}' not available"
      return 1
    fi
  fi

  cd "$dir_drive" 2>/dev/null || {
    scold "'${myDrive}' not available at ${dir_drive}"
    return 1
  }
}
