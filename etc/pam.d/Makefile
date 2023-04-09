# ----------------------------------------------------------------------------
# custom pam(8) module to allow `sudo` authentication via Apple Watch
# ----------------------------------------------------------------------------

include ../../common.mk

install: /etc/pam.d/sudo

/etc/pam.d/sudo: sudo.patch | $(libdir)/pam/pam_reattach.so $(libdir)/pam/pam_watchid.so.2
	sudo patch -i $< /etc/pam.d/sudo
$(libdir)/pam/pam_reattach.so: | /usr/local/bin/brew
	brew install pam-reattach

PAM_REPO := biscuitehh/pam-watchid
$(libdir)/pam/pam_watchid.so.2: | $(GIT_STAGING)/$(PAM_REPO)
	cd $| && sudo $(MAKE) install
$(GIT_STAGING)/$(PAM_REPO):
	cd $(GIT_STAGING) && git clone git@github.com:$(PAM_REPO).git $(PAM_REPO)
