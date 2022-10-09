.DEFAULT_GOAL = dircolors/all

include ../common.mk

outdir := $(datadir)/dircolors

.PHONY: dircolors/all
dircolors/all: thirty2k

.PHONY: thirty2k
thirty2k: $(outdir)/thirty2k.ls_colors $(outdir)/thirty2k.ls_colors.fish

$(outdir)/%.ls_colors: %.dircolors | $(outdir)/
	dircolors -b $< >$@

$(outdir)/%.ls_colors.fish: %.dircolors | $(outdir)/
	dircolors -c $< >$@

$(outdir)/:
	mkdir -pv $(outdir)

.PHONY: uninstall
uninstall:
	rm -fv $(outdir)/thirty2k.*
