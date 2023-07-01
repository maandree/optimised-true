.POSIX:

MACHINE != uname -m
MACHINE !=\
	if test -d "$(MACHINE)"; then \
		printf '%s\n' "$(MACHINE)"; \
	else \
		printf '%s\n' "generic"; \
	fi

CONFIGFILE = config.mk
include $(CONFIGFILE)

BIN = true false

all: $(BIN)
true: true.o
false: false.o

.SUFFIXES:
.SUFFIXES: .o

include $(MACHINE)/build.mk

check: $(BIN:=-check)

true-check: true
	./true
	./true
	./true
	./true
	./true
	./true
	./true
	./true
	./true
	./true

false-check: false
	set +e; ./false; test $$? = 1 || exit 1
	set +e; ./false; test $$? = 1 || exit 1
	set +e; ./false; test $$? = 1 || exit 1
	set +e; ./false; test $$? = 1 || exit 1
	set +e; ./false; test $$? = 1 || exit 1
	set +e; ./false; test $$? = 1 || exit 1
	set +e; ./false; test $$? = 1 || exit 1
	set +e; ./false; test $$? = 1 || exit 1
	set +e; ./false; test $$? = 1 || exit 1
	set +e; ./false; test $$? = 1 || exit 1

install: $(BIN)
	mkdir -p -- "$(DESTDIR)/$(PREFIX)/bin"
	cp -- $(BIN) "$(DESTDIR)/$(PREFIX)/bin"
	cd -- "$(DESTDIR)/$(PREFIX)/bin" && chmod -- 755 "$(BIN)"

uninstall:
	-cd -- "$(DESTDIR)/$(PREFIX)/bin" && rm -f -- $(BIN)
	-rmdir -- "$(DESTDIR)/$(PREFIX)/bin"

clean:
	-rm -f -- *.o *.su $(BIN)

.PHONY: all check true-check false-check install uninstall clean
