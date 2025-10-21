function fish_title_tab --description "Output the tab title"
    echo -ns (prompt_hostname) ":" (prompt_pwd -z)
end
