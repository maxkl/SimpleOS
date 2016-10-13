
SRC_DIR = src/
BUILD_DIR = build/

CC = i386-elf-gcc
CFLAGS = -Wall -ffreestanding

LD = i386-elf-ld
LDFLAGS =

NASM = nasm
NASMFLAGS = -I'$(SRC_DIR)'

all: $(BUILD_DIR) $(BUILD_DIR)/simple.bin

.PHONY: clean
clean:
	rm -rf $(BUILD_DIR)

$(BUILD_DIR)/kernel.bin: $(BUILD_DIR)/kernel_entry.o $(BUILD_DIR)/kernel.o
	$(LD) -o $@ -Ttext 0x1000 $^ --oformat binary

$(BUILD_DIR)/kernel_entry.o: $(SRC_DIR)/kernel_entry.asm
	$(NASM) $(NASMFLAGS) -f elf -o $@ $<

$(BUILD_DIR)/kernel.o: $(SRC_DIR)/kernel.c
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR)/boot.bin: $(SRC_DIR)/boot.asm
	$(NASM) $(NASMFLAGS) -f bin -o $@ $<

$(BUILD_DIR)/simple.bin: $(BUILD_DIR)/boot.bin $(BUILD_DIR)/kernel.bin
	cat $^ > $@

$(BUILD_DIR):
	echo "Creating build dir"
	mkdir -p $@

run: all
	qemu-system-x86_64 -fda $(BUILD_DIR)/simple.bin
