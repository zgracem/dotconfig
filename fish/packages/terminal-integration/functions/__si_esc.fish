function __si_esc -d "Emit escape sequences for shell integration"
    set --local OSC "\e]"
    set --local ST "\a"
    builtin printf "$OSC$__si_Ps;%s$ST" (string join ";" $argv)
end
