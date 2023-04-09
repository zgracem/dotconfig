.ONESHELL:

APP := WaitForLogout.app
AUTHOR := Zozo
VERSION := 1.0.0
YEAR := $(shell date +%Y)

build: $(APP)/Contents/Info.plist $(APP)

include ../common.mk

install: build

# Use macOS's own `mv` to properly preserve OS metadata.
MV := /bin/mv

# Compile to app bundle, and rename executable for discovery by e.g. `killall`.
$(APP): WaitForLogout.applescript
	osacompile -o $@ $< \
	&& $(MV) $@/Contents/MacOS/applet $@/Contents/MacOS/WaitForLogout

# Add new executable name and bundle id, set to "Stay open after run handler,"
# and hide app from Dock when it's active.
$(APP)/Contents/Info.plist: $(APP)
	. add_or_set.sh $@ \
	&& add_or_set :CFBundleExecutable string WaitForLogout \
	&& add_or_set :CFBundleIdentifier string org.inescapable.wait-for-logout \
	&& add_or_set :CFBundleShortVersionString string $(VERSION) \
	&& add_or_set :NSHumanReadableCopyright string "Copyright © $(YEAR) $(AUTHOR)" \
	&& add_or_set :OSAAppletStayOpen bool true \
	&& add_or_set :NSUIElement string 1

# Install app bundle to ~/Applications
$(HOME)/Applications/$(APP): $(APP) | $(HOME)/Applications
	killall -q WaitForLogout; \
	$(MV) $< $@
$(HOME)/Applications:
	mkdir $@

# Remove existing login item (if any), then add as new login item.
.PHONY: add-login-item
add-login-item: $(HOME)/Applications/$(APP)
	osascript \
	-e 'tell application "System Events"' \
	-e 'if the name of every login item contains "WaitForLogout" then delete login item "WaitForLogout"' \
	-e 'end tell'
	osascript \
	-e 'tell application "System Events"' \
	-e 'make login item at end with properties {path:"$<", hidden:true}' \
	-e 'end tell'
install: add-login-item

.PHONY: clean
clean:
	rm -rf $(APP)
