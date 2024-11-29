function __fish_has_mode_prompt -d "Returns true if fish_mode_prompt is defined and not empty"
    functions fish_mode_prompt | string match -rvq '^ *(#|function |end$|$)'
end
