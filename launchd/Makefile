SOURCE_DIR = .
DEST_DIR = $(HOME)/Library/LaunchAgents

LIBS = -rplist -ryaml

# `make` with no arguments executes the first rule in the file.
env: $(DEST_DIR)/org.inescapable.environment.plist

$(DEST_DIR)/%.plist: $(SOURCE_DIR)/%.plist.yaml
	launchctl unload $@
	ruby $(LIBS) -e'puts YAML.load(File.read("$(realpath $^)")).to_plist' > $@
	launchctl load $@
