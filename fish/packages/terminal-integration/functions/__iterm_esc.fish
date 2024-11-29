function __iterm_esc -d "Emit escape sequences for iTerm.app shell integration"
    set --local --export __si_Ps 1337
    __si_esc $argv
end
