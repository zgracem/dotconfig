function errno --description 'Display information about error codes' -a num
  set -l last_exit $status

  if test -z "$num"
    set num $last_exit
  end

  if test "$num" -eq 0
    echo -s "[ Exit code " (set_color brgreen) $num (set_color normal) " ]"
    echo "OK"
    return 0
  end

  echo -s "[ Error code " (set_color brred) $num (set_color normal) " ]"

  _errno_fish $num
  _errno_signal $num
  _errno_sysexit $num
  _errno_posix $num
  _errno_curl $num
end
