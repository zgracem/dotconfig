# Common prefix for some or all installation directories.
# The default value of prefix should be /usr/local.
prefix = /usr/local

# Common prefix for some installation directories.
# The default value of exec_prefix should be $(prefix).
# Generally, $(exec_prefix) is for machine-specific directories, while $(prefix) is for other directories.
exec_prefix = $(prefix)

# ----------------------------------------------------------------------------
# Executable programs are installed in one of the following directories:
# ----------------------------------------------------------------------------

# The directory for executable programs that users can run.
# This should normally be /usr/local/bin, but write it as $(exec_prefix)/bin.
bindir = $(exec_prefix)/bin

# The directory for executable programs that can be run from the shell,
# but are only generally useful to system administrators.
# This should normally be /usr/local/sbin, but write it as $(exec_prefix)/sbin.
sbindir = $(exec_prefix)/sbin

# The directory for executable programs to be run by other programs rather than by users.
# This directory should normally be /usr/local/libexec, but write it as $(exec_prefix)/libexec.
# You should install your data in a subdirectory thereof.
# Most packages install their data under $(libexecdir)/package-name/.
libexecdir = $(exec_prefix)/libexec # $(libexecdir)/package-name

# ----------------------------------------------------------------------------
# Data files used by the program during its execution:
# ----------------------------------------------------------------------------

# The root directory for read-only arch-independent data files.
# This should normally be /usr/local/share, but write it as $(prefix)/share.
datarootdir = $(prefix)/share

# The directory for idiosyncratic read-only arch-independent data files.
# This should normally be /usr/local/share, but write it as $(datarootdir).
# You should install your data in a subdirectory thereof.
# Most packages install their data under $(datadir)/package-name/.
datadir = $(datarootdir) # $(datadir)/package-name

# The directory for installing read-only data files for a single machine,
# i.e. files for configuring a host.
# All the files in this directory should be ordinary ASCII text files.
# This directory should normally be /usr/local/etc, but write it as $(prefix)/etc.
sysconfdir = $(prefix)/etc

# The directory for installing arch-independent data files
# which the programs modify while they run.
# This should normally be /usr/local/com, but write it as $(prefix)/com.
sharedstatedir = $(prefix)/com

# The directory for machine-specific data files modified while programs run.
# $(localstatedir) should normally be /usr/local/var, but write it as $(prefix)/var.
localstatedir = $(prefix)/var

# Like localstatedir, but for semi-permanent temporary files,
# e.g. PID files for system daemons.
# This should normally be /var/run, but write it as $(localstatedir)/run.
runstatedir = $(localstatedir)/run

# The directory for header files to be included by user programs with the C `#include` preprocessor directive.
# This should normally be /usr/local/include, but write it as $(prefix)/include.
includedir = $(prefix)/include
# The directory for installing `#include` header files for use with compilers other than GCC.
# This should normally be /usr/include.
oldincludedir = /usr/include

# The directory for installing documentation files (other than Info) for this package.
# By default, it should be /usr/local/share/doc/package-name, but it should be written as $(datarootdir)/doc/package-name.
docdir = $(datarootdir)/doc/package-name

# The directory for installing the Info files for this package.
# By default, it should be /usr/local/share/info, but it should be written as $(datarootdir)/info.
infodir = $(datarootdir)/info

# Directories for installing documentation files in the particular format.
# They should all be set to $(docdir) by default.
# Packages which supply this documentation should install them in
# `$(htmldir)/ll`, `$(pdfdir)/ll`, etc. where ll is any valid locale abbreviation.
htmldir = $(docdir) # $(htmldir)/en_CA
dvidir = $(docdir) # $(dvidir)/en_CA
pdfdir = $(docdir) # $(pdfdir)/en_CA
psdir = $(docdir) # $(psdir)/en_CA

# The directory for object files and libraries of object code.
# The value of libdir should normally be /usr/local/lib, but write it as $(exec_prefix)/lib.
libdir = $(exec_prefix)/lib

# The directory for installing locale-specific message catalogs for this package.
# By default, it should be /usr/local/share/locale, but it should be written as $(datarootdir)/locale.
# This directory usually has a subdirectory per locale.
localedir = $(datarootdir)/locale # $(datarootdir)/locale/en_CA

# ----------------------------------------------------------------------------
# Unix-style man pages are installed in one of the following:
# ----------------------------------------------------------------------------

# The top-level directory for installing the man pages (if any) for this package.
# It will normally be /usr/local/share/man, but you should write it as $(datarootdir)/man.
mandir = $(datarootdir)/man
## For section 1 man pages...
# man1dir = $(mandir)/man1
## For section 2 man pages...
# man2dir = $(mandir)/man2

# The file name extension for the installed man page.
# This should contain a period followed by the appropriate digit.
manext = .1
## Use these names instead of `manext` if the package needs to install man pages
## in more than one section of the manual:
# man1ext = .1
# man2ext = .2

# The directory for the sources being compiled.
# The value of this variable is normally inserted by the `configure` shell script.
srcdir =
