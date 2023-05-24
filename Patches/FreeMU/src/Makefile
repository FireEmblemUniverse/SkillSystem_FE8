.SUFFIXES:
.PHONY: all clean lyn


# Making sure devkitARM exists and is set up.
ifeq ($(strip $(DEVKITARM)),)
	$(error "Please set DEVKITARM in your environment. export DEVKITARM=<path to>devkitARM")
endif

# Including devkitARM tool definitions
include $(DEVKITARM)/base_tools


# ==================
# = OBJECTS & DMPS =
# ==================

# defining path of lyn
LYN := $(DEVKITARM)/lyn -longcalls

# reference object
LYNREF := _include/_Definitions.h.o

# OBJ to event
%.lyn.event: %.o $(LYNREF)
	$(NOTIFY_PROCESS)
	$(LYN) $< $(LYNREF) > $@

# OBJ to DMP rule
%.dmp: %.o
	$(NOTIFY_PROCESS)
	$(OBJCOPY) -S $< -O binary $@




# ========================
# = ASSEMBLY/COMPILATION =
# ========================

# Setting C/ASM include directories up
INCLUDE_DIRS := _include _inc
INCFLAGS     := $(foreach dir, $(INCLUDE_DIRS), -I "$(dir)")

# setting up compilation flags
ARCH    := -mcpu=arm7tdmi -mthumb -mthumb-interwork
CFLAGS  := $(ARCH) $(INCFLAGS) -Wall -Os -mtune=arm7tdmi -ffreestanding -mlong-calls
ASFLAGS := $(ARCH) $(INCFLAGS)

# defining dependency flags
CDEPFLAGS = -MMD -MT "$*.o" -MT "$*.asm" -MF "$(CACHE_DIR)/$(notdir $*).d" -MP
SDEPFLAGS = --MD "$(CACHE_DIR)/$(notdir $*).d"

# ASM to OBJ rule
%.o: %.s
	$(NOTIFY_PROCESS)
	$(AS) $(ASFLAGS) $(SDEPFLAGS) -I $(dir $<) $< -o $@ $(ERROR_FILTER)

# C to ASM rule
# I would be fine with generating an intermediate .s file but this breaks dependencies
%.o: %.c
	$(NOTIFY_PROCESS)
	$(CC) $(CFLAGS) $(CDEPFLAGS) -g -c $< -o $@ $(ERROR_FILTER)

# C to ASM rule
%.asm: %.c
	$(NOTIFY_PROCESS)
	$(CC) $(CFLAGS) $(CDEPFLAGS) -S $< -o $@ -fverbose-asm $(ERROR_FILTER)

# Avoid make deleting objects it thinks it doesn't need anymore
# Without this make may fail to detect some files as being up to date
.PRECIOUS: %.o;



# ==============
# = MAKE CLEAN =
# ==============
ASMFILES := $(CFILES:.c=.asm)
LYNFILES := $(OFILES:.o=.lyn.event)
DMPFILES := $(OFILErrS:.o=.dmp)
CLEAN_FILES := $(OFILES) $(ASMFILES) $(LYNFILES)

ifeq ($(MAKECMDGOALS),clean)
  CFILES := $(shell find -type f -name '*.c')
  SFILES := $(shell find -type f -name '*.s')
# ASM_C_GENERATED := $(CFILES:.c=.o) $(SFILES:.s=.o) $(CFILES:.c=.asm)
  ASM_C_GENERATED := $(CFILES:.c=.o) $(CFILES:.c=.asm)
# ASM_C_GENERATED += $(ASM_C_GENERATED:.o=.dmp) $(ASM_C_GENERATED:.o=.lyn.event)
  ASM_C_GENERATED += $(ASM_C_GENERATED:.o=.lyn.event)
  CLEAN_FILES += $(ASM_C_GENERATED)
endif

clean:
	rm -f $(CLEAN_FILES)
	
	
	
# ============
# = MAKE ALL =
# ============
SRC_PATH = ./
SRC_SKILLS_PATH = ./SkillSystem/Skills
SRC_BATTLE_PATH = ./BattleSystemRework

# DIRS = $(shell find $(SRC_PATH) -maxdepth 6 -type d)
DIRS = $(shell find $(SRC_PATH) -type d)

SRC_FILES := $(foreach dir, $(DIRS), $(wildcard $(dir)/*.c))
LYN_TARGET := $(patsubst %.c,%.lyn.event, $(SRC_FILES) )
ASM_TARGET := $(patsubst %.c,%.asm, $(SRC_FILES) )
OBJ_TARGET := $(patsubst %.c,%.o, $(SRC_FILES) )

all:
	$(MAKE) $(ASM_TARGET)
	$(MAKE) $(LYN_TARGET)
	rm -f $(OBJ_TARGET)
	
lyn:
	$(MAKE) $(LYN_TARGET)
	rm -f $(OBJ_TARGET)
	
	

