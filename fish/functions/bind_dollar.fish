function bind_dollar
    switch (commandline --current-token)[-1]
        case "!"
            commandline --current-token ""
            commandline --function history-token-search-backward
        case "*"
            commandline --insert '$'
    end
end
