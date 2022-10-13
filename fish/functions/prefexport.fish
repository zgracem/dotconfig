function prefexport -d "Export defaults to YAML"
    defaults export $argv[1] - | pyjamas --mode=plist:yaml
end
