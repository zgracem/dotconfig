# ----------------------------------------------------------------------------
# Install files to /etc and /usr/local/etc
# ----------------------------------------------------------------------------

.DEFAULT_GOAL = etc/all

include ../common.mk

.PHONY: etc/all

# dnsmasq -- enable local .test TLD
.PHONY: dnsmasq
dnsmasq:
	cd $(XDG_CONFIG_HOME)/etc/dnsmasq && $(MAKE)
# etc/all: dnsmasq

# custom man.conf(5)
.PHONY: man/conf
man/conf: /etc/man.conf
etc/all: man/conf

/etc/man.conf: man.conf
	sudo $(INSTALL_DATA) --backup=existing -- $< $@

# custom pam(8) module to allow `sudo` authentication via Apple Watch
.PHONY: pam/watchid
pam/watchid: /etc/pam.d/sudo
etc/all: pam/watchid

/etc/pam.d/sudo: pam.d/sudo.patch | /usr/local/lib/pam/pam_reattach.so /usr/local/lib/pam/pam_watchid.so.2
	sudo patch -i $< /etc/pam.d/sudo
/usr/local/lib/pam/pam_reattach.so: | /usr/local/bin/brew
	brew install pam-reattach

PAM_REPO := biscuitehh/pam-watchid
/usr/local/lib/pam/pam_watchid.so.2: | $(GIT_STAGING)/$(PAM_REPO)
	cd $< && sudo $(MAKE) install
$(GIT_STAGING)/$(PAM_REPO):
	cd $(GIT_STAGING) && git clone git@github.com:$(PAM_REPO).git $(PAM_REPO)

# custom sudoers(5) config
.PHONY: sudoers
sudoer: /etc/sudoers.d/sudoer_zozo
etc/all: sudoers

/etc/sudoers.d/%: sudoers.d/%
	sudo $(INSTALL_DATA) -- $< $@

# custom ssh_config(5) and sshd_config(5)
.PHONY: etc/ssh
etc/ssh: /etc/ssh/sshd_config.d/999-sshd.conf /etc/ssh/ssh_config.d/999-ssh.conf
etc/all: etc/ssh

/etc/ssh/%.conf: ssh/%.conf
	sudo $(INSTALL_DATA) -- $< $@

# allow `chsh`-ing to shells in /usr/local/bin
.PHONY: shells
shells: | /etc/shells /usr/local/bin/fish
	chsh -s /usr/local/bin/fish
## Not included in `all`; run this manually when needed
# etc/all: shells

/usr/local/bin/fish: | /usr/local/bin/brew
	brew install fish
/etc/shells:
	$(XDG_CONFIG_HOME)/libexec/init-etc-shells.sh fish bash

# fix console spam
.PHONY: emond
emond: /etc/emond.d/rules/SampleRules.plist
etc/all: emond

/etc/emond.d/rules/SampleRules.plist:
	sudo /usr/libexec/PlistBuddy -c "Set 0:enabled true"
