function __vsc_esc -d "Emit escape sequences for VS Code shell integration"
    set --local --export __si_Ps 633
    __si_esc $argv
end
