.SUFFIXES:
.PHONY: all clean

# Making sure devkitARM exists and is set up.
ifeq ($(strip $(DEVKITARM)),)
	$(error "Please set DEVKITARM in your environment. export DEVKITARM=<path to>devkitARM")
endif

# Including devkitARM tool definitions
include $(DEVKITARM)/base_tools
# defining path of lyn
LYN := $(abspath .)/include/Tools/lyn -longcalls

# setting up compilation flags
ARCH   := -mcpu=arm7tdmi -mthumb -mthumb-interwork
CFLAGS := $(ARCH) -Wall -Os -mtune=arm7tdmi  -mlong-calls

# reference object
LYNREF := include/_Definitions.h.o
LYNREF2 := include/MokhaRAMSpace.o

# C to ASM rule
%.asm: %.c
	$(CC) $(CFLAGS) -S $< -o $@ -fverbose-asm

# C to OBJ rule
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@
	
# OBJ to DMP rule
%.dmp: %.o
	$(OBJCOPY) -S $< -O binary $@
	
# OBJ to EVENT rule
%.lyn.event: %.o $(LYNREF)
	$(LYN) $< $(LYNREF) $(LYNREF2) > $@
	
# ASM to OBJ
%.o: %.s
	$(AS) $(ARCH) $< -o $@
	
# listing possible generated asm files
ASMFILES := $(CFILES:.c=.asm)

# listing possible lyn event files
LYNFILES := $(OFILES:.o=.lyn.event)

# listing possible dmp files
DMPFILES := $(OFILES:.o=.dmp)

# "make all" phony target
all: $(OFILES) $(ASMFILES) $(LYNFILES) $(DMPFILES);

# "make clean" phony target
clean:
	rm -f $(OFILES) $(ASMFILES) $(LYNFILES) $(DMPFILES)
	
	