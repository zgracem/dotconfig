# -----------------------------------------------------------------------------
# symlinks
# -----------------------------------------------------------------------------

.PHONY: shell-files

SHELL_FILES := ~/.hushlogin ~/.profile ~/.bash_profile ~/.bashrc ~/.bash_logout

~/.hushlogin: hushlogin
~/.profile: sh/profile.sh
~/.bash_profile: bash/profile.bash
~/.bashrc: bash/bashrc.bash
~/.bash_logout: bash/logout.bash

$(SHELL_FILES):
	ln -s .config/$< $@

shell-files: $(SHELL_FILES)
