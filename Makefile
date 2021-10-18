# dmenukey - dynamic menu one key to select
# See LICENSE file for copyright and license details.

include config.mk

SRC = drw.c dmenukey.c stest.c util.c
OBJ = $(SRC:.c=.o)

all: options dmenukey stest

options:
	@echo dmenukey build options:
	@echo "CFLAGS   = $(CFLAGS)"
	@echo "LDFLAGS  = $(LDFLAGS)"
	@echo "CC       = $(CC)"

.c.o:
	$(CC) -c $(CFLAGS) $<

config.h:
	cp config.def.h $@

$(OBJ): arg.h config.h config.mk drw.h

dmenukey: dmenukey.o drw.o util.o
	$(CC) -o $@ dmenukey.o drw.o util.o $(LDFLAGS)

stest: stest.o
	$(CC) -o $@ stest.o $(LDFLAGS)

clean:
	rm -f dmenukey stest $(OBJ) dmenukey-$(VERSION).tar.gz

dist: clean
	mkdir -p dmenukey-$(VERSION)
	cp LICENSE Makefile README arg.h config.def.h config.mk dmenukey.1\
		drw.h util.h stest.1 $(SRC)\
		dmenukey-$(VERSION)
	tar -cf dmenukey-$(VERSION).tar dmenukey-$(VERSION)
	gzip dmenukey-$(VERSION).tar
	rm -rf dmenukey-$(VERSION)

install: all
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f dmenukey stest $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/dmenukey
	chmod 755 $(DESTDIR)$(PREFIX)/bin/stest
	mkdir -p $(DESTDIR)$(MANPREFIX)/man1
	sed "s/VERSION/$(VERSION)/g" < dmenukey.1 > $(DESTDIR)$(MANPREFIX)/man1/dmenukey.1
	sed "s/VERSION/$(VERSION)/g" < stest.1 > $(DESTDIR)$(MANPREFIX)/man1/stest.1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/dmenukey.1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/stest.1

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/dmenukey\
		$(DESTDIR)$(PREFIX)/bin/stest\
		$(DESTDIR)$(MANPREFIX)/man1/dmenukey.1\
		$(DESTDIR)$(MANPREFIX)/man1/stest.1

.PHONY: all options clean dist install uninstall
