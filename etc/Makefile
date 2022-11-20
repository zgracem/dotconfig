# ----------------------------------------------------------------------------
# Install files to /etc and /usr/local/etc
# ----------------------------------------------------------------------------

prefix ?= /usr/local

include ../common.mk

# ----------------------------------------------------------------------------
# dnsmasq -- enable local .test TLD

.PHONY: dnsmasq
dnsmasq:
	cd $(XDG_CONFIG_HOME)/etc/dnsmasq && $(MAKE)
# install: dnsmasq

dnsmasq/uninstall:
	cd $(XDG_CONFIG_HOME)/etc/dnsmasq && $(MAKE) uninstall

# ----------------------------------------------------------------------------
# custom man.conf(5)

install: /etc/man.conf

/etc/man.conf: man.conf
	sudo $(INSTALL_DATA) --backup=existing -- $< $@

# ----------------------------------------------------------------------------
# custom pam(8) module to allow `sudo` authentication via Apple Watch

install: /etc/pam.d/sudo

/etc/pam.d/sudo: pam.d/sudo.patch | $(libdir)/pam/pam_reattach.so $(libdir)/pam/pam_watchid.so.2
	sudo patch -i $< /etc/pam.d/sudo
$(libdir)/pam/pam_reattach.so: | /usr/local/bin/brew
	brew install pam-reattach

PAM_REPO := biscuitehh/pam-watchid
$(libdir)/pam/pam_watchid.so.2: | $(GIT_STAGING)/$(PAM_REPO)
	cd $| && sudo $(MAKE) install
$(GIT_STAGING)/$(PAM_REPO):
	cd $(GIT_STAGING) && git clone git@github.com:$(PAM_REPO).git $(PAM_REPO)

# ----------------------------------------------------------------------------
# custom sudoers(5) config

install: /etc/sudoers.d/sudoer_zozo

/etc/sudoers.d/%: sudoers.d/%
	sudo $(INSTALL_DATA) -- $< $@

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
	$(XDG_CONFIG_HOME)/libexec/init-etc-shells.sh fish bash

# ----------------------------------------------------------------------------
# fix console spam

install: /etc/emond.d/rules/SampleRules.plist

/etc/emond.d/rules/SampleRules.plist:
	sudo /usr/libexec/PlistBuddy -c "Set 0:enabled true"

.PHONY: emond/uninstall
emond/uninstall:
	sudo /usr/libexec/PlistBuddy -c "Set 0:enabled false"
