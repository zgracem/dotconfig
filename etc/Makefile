# ----------------------------------------------------------------------------
# Install files to /etc and /usr/local/etc
# ----------------------------------------------------------------------------

SHELL := /usr/local/bin/bash
GNU := /usr/local/opt/coreutils/libexec/gnubin
INSTALL := $(GNU)/install -D --compare --mode=0644 --backup=existing --preserve-timestamps

.PHONY: etc/all
etc/all:
	sudo -v

# dnsmasq -- enable local .test TLD
.PHONY: dnsmasq
dnsmasq:
	cd ${XDG_CONFIG_HOME}/etc/dnsmasq && $(MAKE) all
etc/all: dnsmasq

# custom sudoers(5) config
.PHONY: sudoers
sudoer: /etc/sudoers.d/sudoer_zozo
etc/all: sudoers

/etc/sudoers.d/%: sudoers.d/%
	sudo ${INSTALL} -- $< $@

# custom ssh_config(5) and sshd_config(5)
.PHONY: etc/ssh
etc/ssh: /etc/ssh/sshd_config.d/999-sshd.conf /etc/ssh/ssh_config.d/999-ssh.conf
etc/all: etc/ssh

/etc/ssh/%.conf: ssh/%.conf
	sudo ${INSTALL} -- $< $@

# allow `chsh`-ing to shells in /usr/local/bin
.PHONY: shells
shells: | /etc/shells /usr/local/bin/fish
	chsh -s /usr/local/bin/fish
## Not included in `all`; run this manually when needed
# etc/all: shells

/usr/local/bin/%:
	brew install $(notdir $@)
/etc/shells:
	${XDG_CONFIG_HOME}/bin/init/add-to-etc-shells.sh fish bash

# fix console spam
.PHONY: emond
emond: /etc/emond.d/rules/SampleRules.plist
etc/all: emond

/etc/emond.d/rules/SampleRules.plist:
	sudo /usr/libexec/PlistBuddy -c "Set 0:enabled true"
