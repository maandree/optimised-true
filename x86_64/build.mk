ASFLAGS =
LDFLAGS = -s -nodefaultlibs -nostdlib

true.o false.o: $(MACHINE)/true.s $(MACHINE)/false.s
	$(AS) -o $@ $(MACHINE)/$(@:.o=.s) $(ASFLAGS)
