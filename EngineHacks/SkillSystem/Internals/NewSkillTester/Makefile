.SUFFIXES:
.PHONY:

# Making sure devkitARM exists and is set up.
ifeq ($(strip $(DEVKITARM)),)
	$(error "Please set DEVKITARM in your environment. export DEVKITARM=<path to>devkitARM")
endif

# Including devkitARM tool definitions
include $(DEVKITARM)/base_tools

# defining path of lyn
LYN := "$(abspath .)/lyn"
LYNREF :="$(abspath .)/reference/SkillsRef.o"

# setting up compilation flags
ARCH   := -mcpu=arm7tdmi -mthumb -mthumb-interwork
CFLAGS := $(ARCH) -Wall -Os -mtune=arm7tdmi

# header files location
HEADER_FILES := $(abspath .)/include

# C to ASM rule
%.s: %.c
	$(CC) $(CFLAGS) -S $< -I $(HEADER_FILES) -o $@ -fverbose-asm -mlong-calls

# ASM to OBJ
%.o: %.s
	$(AS) $(ARCH) $< -o $@

# OBJ to EVENT rule
%.lyn.event: %.o
	$(LYN) $< $(LYNREF) > $@
