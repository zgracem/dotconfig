function prefexport -d "Export defaults to YAML"
    defaults export $argv - \
    | prettier --parser=yaml \
    | pyjamas --mode=plist:yaml
end
