
.SUFFIXES:
.PHONY:

# Making sure devkitARM exists and is set up.
ifeq ($(strip $(DEVKITARM)),)
	$(error "Please set DEVKITARM in your environment. export DEVKITARM=<path to>devkitARM")
endif

# Including devkitARM tool definitions
include $(DEVKITARM)/base_tools
# defining path of lyn
LYN := $(abspath .)/FE-CLib-master/utility/lyn.exe

# setting up compilation flags
ARCH   := -mcpu=arm7tdmi -mthumb -mthumb-interwork
CFLAGS := $(ARCH) -Wall -Os -mtune=arm7tdmi -mlong-calls

# C to ASM rule
%.s: %.c
	$(CC) $(CFLAGS) -S $< -o $@ -fverbose-asm

# C to OBJ rule
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@
	
# OBJ to EVENT rule
%.lyn.event: %.o Definitions.o
	$(LYN) $^ > $@
	
# ASM to OBJ
%.o: %.s
	$(AS) $(ARCH) $< -o $@
	