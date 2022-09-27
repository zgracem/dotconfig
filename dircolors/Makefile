XDG_CACHE_HOME ?= ~/var/cache
OUTDIR = $(XDG_CACHE_HOME)/dircolors

.PHONY: dircolors/all thirty2k clean
dircolors/all: thirty2k

thirty2k: $(OUTDIR)/thirty2k.ls_colors $(OUTDIR)/thirty2k.ls_colors.fish

$(OUTDIR)/%.ls_colors: %.dir_colors $(OUTDIR)/
	dircolors -b $< > $@

$(OUTDIR)/%.ls_colors.fish: %.dir_colors $(OUTDIR)/
	dircolors -c $< > $@

$(OUTDIR)/:
	mkdir -p $(OUTDIR)

clean:
	rm -f $(OUTDIR)/*.ls_colors
