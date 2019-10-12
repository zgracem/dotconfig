function update_lastpwd --on-variable PWD --on-event fish_exit
  echo "$PWD" > ~/.lastpwd
end
