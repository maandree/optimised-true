CFLAGS  = -nostdinc -ffreestanding
LDFLAGS = -s

LD = $(CC)

true.o false.o: $(MACHINE)/true.c $(MACHINE)/false.c
	$(CC) -c -o $@ $(MACHINE)/$(@:.o=.c) $(CFLAGS)
