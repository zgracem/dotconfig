# ----------------------------------------------------------------------------
# Install files to /etc and /usr/local/etc
# ----------------------------------------------------------------------------

prefix ?= /usr/local

include ../common.mk

# ----------------------------------------------------------------------------
# custom man.conf(5)

install: /etc/man.conf

/etc/man.conf: man.conf
	sudo $(INSTALL_DATA) --backup=existing -- $< $@

# ----------------------------------------------------------------------------
# custom ssh_config(5) and sshd_config(5)

SSH_FILES :=
SSH_FILES += /etc/ssh/ssh_config.d/999-ssh.conf
SSH_FILES += /etc/ssh/sshd_config.d/999-sshd.conf

install: $(SSH_FILES)

/etc/ssh/%.conf: ssh/%.conf
	sudo $(INSTALL_DATA) -- $< $@

.PHONY: ssh/uninstall
ssh/uninstall:
	sudo rm -fv $(SSH_FILES)

# ----------------------------------------------------------------------------
# allow `chsh`-ing to shells in /usr/local/bin

.PHONY: shells
shells: | /etc/shells /usr/local/bin/fish
	chsh -s /usr/local/bin/fish
# install: shells

/usr/local/bin/fish: | /usr/local/bin/brew
	brew install fish
/etc/shells:
	$(XDG_CONFIG_HOME)/libexec/init/etc-shells.sh fish bash

# ----------------------------------------------------------------------------
# fix console spam

install: /etc/emond.d/rules/SampleRules.plist

/etc/emond.d/rules/SampleRules.plist:
	sudo /usr/libexec/PlistBuddy -c "Set 0:enabled true"

.PHONY: emond/uninstall
emond/uninstall:
	sudo /usr/libexec/PlistBuddy -c "Set 0:enabled false"
