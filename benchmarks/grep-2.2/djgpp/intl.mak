# Generated from Makefile.in for DJGPP v2
# Makefile for directory with message catalog handling in GNU NLS Utilities.
# Copyright (C) 1995, 1996 Free Software Foundation, Inc.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

PACKAGE = grep
VERSION = @VERSION@

SHELL = /bin/sh

srcdir = .
top_srcdir = ..

prefix = ${DJDIR}
exec_prefix = ${prefix}
transform = s,x,x,
libdir = $(exec_prefix)/lib
includedir = $(prefix)/include
datadir = $(prefix)/share
localedir = $(datadir)/locale
gnulocaledir = $(prefix)/share/locale
gettextsrcdir = ${prefix}/share/gettext/intl
aliaspath = $(localedir):.
subdir = intl

INSTALL = ${DJDIR}/bin/ginstall -c
INSTALL_DATA = ${INSTALL} -m 644
MKINSTALLDIRS = ./mkinstalldirs

AR = ar
CC = gcc
RANLIB = ranlib

DEFS = -DLOCALEDIR=\"$(localedir)\" -DGNULOCALEDIR=\"$(gnulocaledir)\" \
-DLOCALE_ALIAS_PATH=\"$(aliaspath)\" -DHAVE_CONFIG_H
CFLAGS = -g -O2

COMPILE = $(CC) -c $(DEFS) $(INCLUDES) $(CPPFLAGS) $(CFLAGS) $(XCFLAGS)

HEADERS = $(COMHDRS) libgettext.h loadinfo.h
COMHDRS = gettext.h gettextP.h hash-string.h
SOURCES = $(COMSRCS) intl-compat.c cat-compat.c
COMSRCS = bindtextdom.c dcgettext.c dgettext.c gettext.c \
finddomain.c loadmsgcat.c localealias.c textdomain.c l10nflist.c \
explodename.c
OBJECTS =  bindtextdom.o dcgettext.o dgettext.o gettext.o \
finddomain.o loadmsgcat.o localealias.o textdomain.o l10nflist.o \
explodename.o
CATOBJS = cat-compat.o ../po/cat-id-tbl.o
GETTOBJS = intl-compat.o
DISTFILES.common = ChangeLog Makefile.in linux-msg.sed po2tbl-in.sed \
xopen-msg.sed $(HEADERS) $(SOURCES)
DISTFILES.normal = VERSION
DISTFILES.gettext = libintl.glibc intlh.inst.in

.SUFFIXES:
.SUFFIXES: .c .o
.c.o:
	$(COMPILE) $<

INCLUDES = -I.. -I. -I$(top_srcdir)/intl -I$(top_srcdir)/lib

all: all-no

all-yes: libintl.a intlh.inst
all-no:

libintl.a: $(OBJECTS)
	rm -f $@
	$(AR) cru $@ $(OBJECTS)
	$(RANLIB) $@

../po/cat-id-tbl.o: ../po/cat-id-tbl.c $(top_srcdir)/po/$(PACKAGE).pot
	cd ../po && $(MAKE) cat-id-tbl.o

check: all

# This installation goal is only used in GNU gettext.  Packages which
# only use the library should use install instead.

# We must not install the libintl.h/libintl.a files if we are on a
# system which has the gettext() function in its C library or in a
# separate library or use the catgets interface.  A special case is
# where configure found a previously installed GNU gettext library.
# If you want to use the one which comes with this version of the
# package, you have to use `configure --with-included-gettext'.
install: install-exec install-data
install-exec: all
	if test "$(PACKAGE)" = "gettext" \
	   && test '' = '$(GETTOBJS)'; then \
	  if test -r $(MKINSTALLDIRS); then \
	    $(MKINSTALLDIRS) $(libdir) $(includedir); \
	  else \
	    $(top_srcdir)/mkinstalldirs $(libdir) $(includedir); \
	  fi; \
	  $(INSTALL_DATA) intlh.inst $(includedir)/libintl.h; \
	  $(INSTALL_DATA) libintl.a $(libdir)/libintl.a; \
	else \
	  : ; \
	fi
install-data: all
	if test "$(PACKAGE)" = "gettext"; then \
	  if test -r $(MKINSTALLDIRS); then \
	    $(MKINSTALLDIRS) $(gettextsrcdir); \
	  else \
	    $(top_srcdir)/mkinstalldirs $(gettextsrcdir); \
	  fi; \
	  $(INSTALL_DATA) VERSION $(gettextsrcdir)/VERSION; \
	  cd $(srcdir) && \
	  dists="$(DISTFILES.common)"; \
	  for file in $$dists; do \
	    $(INSTALL_DATA) $$file $(gettextsrcdir)/$$file; \
	  done; \
	else \
	  : ; \
	fi

# Define this as empty until I found a useful application.
installcheck:

uninstall:
	dists="$(DISTFILES)"; \
	for file in $$dists; do \
	  rm -f $(gettextsrcdir)/$$file; \
	done

info dvi:

$(OBJECTS): ../config.h libgettext.h
bindtextdom.o finddomain.o loadmsgcat.o: gettextP.h gettext.h loadinfo.h
dcgettext.o: gettextP.h gettext.h hash-string.h loadinfo.h

tags: TAGS

TAGS: $(HEADERS) $(SOURCES)
	here=`pwd`; cd $(srcdir) && etags -o $$here/TAGS $(HEADERS) $(SOURCES)

id: ID

ID: $(HEADERS) $(SOURCES)
	here=`pwd`; cd $(srcdir) && mkid -f$$here/ID $(HEADERS) $(SOURCES)


mostlyclean:
	rm -f *.a *.o core core.*

clean: mostlyclean

distclean: clean
	rm -f Makefile ID TAGS po2msg.sed po2tbl.sed libintl.h

maintainer-clean: distclean
	@echo "This command is intended for maintainers to use;"
	@echo "it deletes files that may require special tools to rebuild."


# GNU gettext needs not contain the file `VERSION' but contains some
# other files which should not be distributed in other packages.
distdir = ../$(PACKAGE)-$(VERSION)/$(subdir)
dist distdir: Makefile $(DISTFILES)
	if test "$(PACKAGE)" = gettext; then \
	  additional="$(DISTFILES.gettext)"; \
	else \
	  additional="$(DISTFILES.normal)"; \
	fi; \
	for file in $(DISTFILES.common) $$additional; do \
	  ln $(srcdir)/$$file $(distdir) 2> /dev/null \
	    || cp -p $(srcdir)/$$file $(distdir); \
	done

dist-libc:
	tar zcvf intl-glibc.tar.gz $(COMSRCS) $(COMHDRS) libintl.h.glibc

# The dependency for intlh.inst is different in gettext and all other
# packages.  Because we cannot you GNU make features we have to solve
# the problem while rewriting Makefile.in.
#YES#intlh.inst: intlh.inst.in ../config.status
#YES#	cd .. \
#YES#	&& CONFIG_FILES=$(subdir)/$@ CONFIG_HEADERS= \
#YES#	  $(SHELL) ./config.status
.PHONY: intlh.inst
intlh.inst:

# Tell versions [3.59,3.63) of GNU make not to export all variables.
# Otherwise a system limit (for SysV at least) may be exceeded.
.NOEXPORT:
