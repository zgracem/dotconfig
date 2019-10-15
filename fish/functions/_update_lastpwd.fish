function _update_lastpwd --on-variable PWD
  echo "$PWD" > ~/.lastpwd
end
