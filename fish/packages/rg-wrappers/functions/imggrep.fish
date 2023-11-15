function imggrep -d "Search images (slowly) with ripgrep"
    command rg --type=img --pre=$XDG_CONFIG_HOME/libexec/pre-rg.fish $argv
end
