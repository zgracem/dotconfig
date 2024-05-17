function lynxx -d "Launch lynx with a fake user-agent"
    command -q lynx; or return 127
    set -l user_agent (cat $XDG_CACHE_HOME/dotfiles/user-agent.txt)
    command lynx -useragent $user_agent $argv
end
