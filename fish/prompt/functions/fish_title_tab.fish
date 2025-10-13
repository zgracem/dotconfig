function fish_title_tab --description 'Update the tab title'
    echo -ns (prompt_hostname) ":" (prompt_pwd -P0 -M0 -k1 -cR)
end
