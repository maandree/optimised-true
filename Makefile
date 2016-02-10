PREFIX = /usr/local
EXEC_PREFIX = $(PREFIX)
BINDIR = $(EXEC_PREFIX)/bin
DATADIR = $(PREFIX)/share
LICENSEDIR = $(DATADIR)/licenses

PKGNAME = optimised-true

LD_FLAGS = -s
AS_FLAGS =
CC_FLAGS = -nostdinc -ffreestanding
MACHINE = $(shell uname -m)

ifneq ($(shell test -d $(MACHINE) && echo 0 || echo 1),0)
GENERIC = 1
LD = $(CC)
endif
ifndef GENERIC
LD_FLAGS += -nodefaultlibs -nostdlib
endif


all: true false

true: true.o
	$(LD) $(LD_FLAGS) -o $@ $^
false: false.o
	$(LD) $(LD_FLAGS) -o $@ $^

ifdef GENERIC
%.o: generic/%.c
	$(CC) $(CC_FLAGS) -c -o $@ $^
endif
ifndef GENERIC
%.o: $(MACHINE)/%.s
	$(AS) $(AS_FLAGS) -o $@ $^
endif

install: true false
	mkdir -p -- "$(DESTDIR)$(BINDIR)" "$(DESTDIR)$(LICENSEDIR)/$(PKGNAME)"
	cp true false -- "$(DESTDIR)$(BINDIR)"
	chmod 755 -- "$(DESTDIR)$(BINDIR)/true"
	chmod 755 -- "$(DESTDIR)$(BINDIR)/false"
	cp COPYING -- "$(DESTDIR)$(LICENSEDIR)/$(PKGNAME)"
	chmod 644 -- "$(DESTDIR)$(LICENSEDIR)/$(PKGNAME)/COPYING"

uninstall:
	-rm -- "$(DESTDIR)$(BINDIR)/true"
	-rm -- "$(DESTDIR)$(BINDIR)/false"
	-rmdir -- "$(DESTDIR)$(BINDIR)"
	-rm -- "$(DESTDIR)$(LICENSEDIR)/$(PKGNAME)/COPYING"
	-rmdir "$(DESTDIR)$(LICENSEDIR)/$(PKGNAME)"

clean:
	-rm true.o true false.o false

.PHONY: all clean install uninstall

