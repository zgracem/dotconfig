# https://fishshell.com/docs/4.0/cmds/fish_should_add_to_history.html
function fish_should_add_to_history
    # don't save commands w/ leading space or comment character
    string match -rq '^[\s#]' $argv
    and return 1

    # don't save common query commands
    string match -rq "^(art|(comp|func|man)src|halp|wtf)\b" $argv
    and return 1

    return 0
end
