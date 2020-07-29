.PHONY: shell-files

SHELL_FILES := ~/.hushlogin \
							 ~/.profile \
							 ~/.bash_sessions_disable \
							 ~/.bash_profile \
							 ~/.bashrc \
							 ~/.bash_logout

.src/skel/%:
	install -pm 0644 -- $< $(HOME)

~/.hushlogin: .src/skel/.hushlogin
~/.profile: .src/skel/.profile
~/.bash_sessions_disable: .src/skel/.bash_sessions_disable
~/.bash_profile: .src/skel/.bash_profile
~/.bashrc: .src/skel/.bashrc
~/.bash_logout: .src/skel/.bash_logout

$(SHELL_FILES):
	/bin/install -pm 0644 -- $< $(HOME)

shell-files: $(SHELL_FILES)
