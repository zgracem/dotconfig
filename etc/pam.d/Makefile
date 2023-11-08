# ----------------------------------------------------------------------------
# custom pam(8) module to allow `sudo` authentication via Apple Watch
# ----------------------------------------------------------------------------

prefix ?= /usr/local

include ../../common.mk

PAM_DIR := $(libdir)/pam
PAM_REPO := zgracem/pam-watchid

install: /etc/pam.d/sudo
/etc/pam.d/sudo: sudo.patch | $(PAM_DIR)/pam_reattach.so $(PAM_DIR)/pam_watchid.so.2
	sudo patch -i $< $@

$(PAM_DIR)/pam_reattach.so:
	brew unlink pam-reattach && brew link pam-reattach
$(PAM_DIR)/pam_watchid.so.2: | $(GIT_STAGING)/$(PAM_REPO)/pam_watchid.so
	cd $(|D) && sudo $(MAKE) install

$(GIT_STAGING)/$(PAM_REPO)/pam_watchid.so:
	git -C $(GIT_STAGING) clone git@github.com:$(PAM_REPO).git $(PAM_REPO) \
	&& git checkout build-with-sdk
