# ----------------------------------------------------------------------------
# Install files to /etc and /usr/local/etc
# ----------------------------------------------------------------------------

.PHONY: all

DOTFILES := $(CURDIR)/..
GNU := /usr/local/opt/coreutils/libexec/gnubin
INSTALL := $(GNU)/install --mode=0644 --preserve-timestamps

# dnsmasq -- enable local .test TLD
.PHONY: dnsmasq
dnsmasq: /usr/local/etc/dnsmasq.conf /etc/resolver/test
all: dnsmasq

/usr/local/etc/dnsmasq.conf: dnsmasq/dnsmasq.conf
	${INSTALL} -D -- $< $@

/etc/resolver/test: dnsmasq/resolver/test
	sudo ${INSTALL} -D -- $< $@

# custom sudoers(5) config
.PHONY: sudoers
sudoer: /etc/sudoers.d/sudoer_zozo
all: sudoers

/etc/sudoers.d/%: sudoers.d/%
	sudo ${INSTALL} -D -- $< $@

# custom ssh_config(5) and sshd_config(5)
.PHONY: etc/ssh
etc/ssh: /etc/ssh/sshd_config.d/999-sshd.conf /etc/ssh/ssh_config.d/999-ssh.conf
all: etc/ssh

/etc/ssh/%.conf: ssh/%.conf
	sudo ${INSTALL} -D -- $< $@

# allow `chsh`-ing to shells in /usr/local/bin
.PHONY: shells
shells: | /etc/shells /usr/local/bin/fish
	chsh -s /usr/local/bin/fish
all: shells

/usr/local/bin/%:
	brew install $(notdir $@)
/etc/shells:
	${DOTFILES}/libexec/init/add-to-etc-shells.sh fish bash

# fix console spam
.PHONY: emond
emond: /etc/emond.d/rules/SampleRules.plist
all: emond

/etc/emond.d/rules/SampleRules.plist:
	sudo /usr/libexec/PlistBuddy -c "Set 0:enabled true"
