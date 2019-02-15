.PHONY: thirty2k default clean all

XDG_CACHE_HOME ?= ~/var/cache
OUTDIR = $(XDG_CACHE_HOME)/dircolors

all: thirty2k default
thirty2k: $(OUTDIR)/thirty2k.ls_colors $(OUTDIR)/thirty2k.ls_colors.fish
default: $(OUTDIR)/default.ls_colors $(OUTDIR)/default.ls_colors.fish

$(OUTDIR)/%.ls_colors: %.dir_colors $(OUTDIR)/
	dircolors -b $< > $@

$(OUTDIR)/%.ls_colors.fish: %.dir_colors $(OUTDIR)/
	dircolors -c $< > $@

$(OUTDIR)/:
	mkdir -p $(OUTDIR)

clean:
	rm -f $(OUTDIR)/*.ls_colors
