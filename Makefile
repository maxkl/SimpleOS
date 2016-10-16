
# Directory names
src_dir := src
out_dir := out

# C compiler
CC := i386-elf-gcc
CFLAGS := -Wall -ffreestanding -I"$(src_dir)/include"

# Linker
LD := i386-elf-ld
LDFLAGS :=

# Assembler
NASM := nasm
NASMFLAGS := -I'$(src_dir)/'

all: $(out_dir)/Image

.PHONY: clean
clean:
	rm -rf $(out_dir)

# Run the image in qemu
.PHONY: run
run: $(out_dir)/Image
	qemu-system-x86_64 -fda $(out_dir)/Image

# These directories will be searched for a Makefile
MODULES := boot kernel drivers

# Set up variables for included Makefiles
libs :=
srcs :=

# Include sub-Makefiles
include $(patsubst %, $(src_dir)/%/Makefile,$(MODULES))

csrcs := $(filter %.c,$(srcs))

objs := $(patsubst %.c,$(out_dir)/%.o,$(csrcs))
obj-dirs := $(dir $(objs))

# Build a .c file to an object
# Also generates a corresponding .d file for faster building
%.o: %.c
$(out_dir)/%.o: $(src_dir)/%.c $(out_dir)/%.d
	@[ -d $(dir $@) ] || mkdir -p $(dir $@)
	$(CC) -MT "$@" -MMD -MP -MF "$(out_dir)/$*.Td" $(CFLAGS) -o "$@" -c "$<"
	mv -f "$(out_dir)/$*.Td" "$(out_dir)/$*.d"

# Link the kernel
$(out_dir)/kernel.bin: $(out_dir)/boot/kernel_entry.o $(out_dir)/kernel/kernel.o
	@[ -d $(dir $@) ] || mkdir -p $(dir $@)
	$(LD) $(LDFLAGS) -o $@ -Ttext 0x1000 $^ --oformat binary

# Concenate bootloader and kernel
$(out_dir)/Image: $(out_dir)/boot/boot.bin $(out_dir)/kernel.bin
	@[ -d $(dir $@) ] || mkdir -p $(dir $@)
	cat $^ > $@

#
$(out_dir)/%.d: ;
.PRECIOUS: $(out_dir)/%.d

# Include .d files, but only if we are not clean-ing
deps = $(patsubst %.o,%.d,$(objs))
ifeq ($(filter $(MAKECMDGOALS),clean),)
-include $(deps)
endif
