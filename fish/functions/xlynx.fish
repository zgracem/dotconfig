function xlynx
    set -l user_agent (cat $XDG_CACHE_HOME/dotfiles/user-agent.txt)
    command lynx -useragent $user_agent $argv
end
