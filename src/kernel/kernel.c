
#include <test.h>

void dummy() {

}

void kernel_main() {
	// 0xb8000 is where the VGA memory resides
    char *video_memory = (char *) 0xb8000;
	// Write a single character to the screen
    *video_memory = TEST_CHAR;
}
