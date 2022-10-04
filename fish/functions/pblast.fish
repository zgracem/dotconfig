function pblast --description "Copy the last command to clipboard"
    history -n1 | tbcopy
end
