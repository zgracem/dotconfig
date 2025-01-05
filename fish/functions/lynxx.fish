function lynxx -d "Launch lynx with a fake user-agent"
    command -q lynx; or return 127
    set -l user_agent (make -C $XDG_CONFIG_HOME print-user-agent); or return
    command lynx -useragent $user_agent $argv
end
