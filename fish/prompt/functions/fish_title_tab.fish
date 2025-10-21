function fish_title_tab --description "Output the tab title"
    echo -ns (my-prompt-hostname) ":" (my-prompt-pwd -z)
end
