function update-lastpwd --on-variable PWD
    test -n "$fish_private_mode"; and return
    echo "$PWD" >$__fish_user_data_dir/last_pwd
end
