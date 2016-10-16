
# Build kernel_entry.o as ELF because it has to be linked with kernel/kernel.o
$(out_dir)/boot/kernel_entry.o: $(src_dir)/boot/kernel_entry.asm
	@[ -d $(dir $@) ] || mkdir -p $(dir $@)
	$(NASM) $(NASMFLAGS) -f elf -o $@ $<

$(out_dir)/boot/boot.bin: $(src_dir)/boot/boot.asm
	@[ -d $(dir $@) ] || mkdir -p $(dir $@)
	$(NASM) $(NASMFLAGS) -f bin -o $@ $<
