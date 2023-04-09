# ----------------------------------------------------------------------------
# custom ssh_config(5) and sshd_config(5)
# ----------------------------------------------------------------------------

include ../../common.mk

SSH_FILES :=
SSH_FILES += /etc/ssh/ssh_config.d/999-ssh.conf
SSH_FILES += /etc/ssh/sshd_config.d/999-sshd.conf

install: $(SSH_FILES)

/etc/ssh/%.conf: %.conf
	sudo $(INSTALL_DATA) -- $< $@

.PHONY: uninstall
uninstall:
	sudo rm -fv $(SSH_FILES)
