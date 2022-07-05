
# ==================
# = OBJECTS & DMPS =
# ==================

# LYN_REFERENCE := Tools/CLib/reference/FE8U-20190316.o
LYN_REFERENCE := Tools/CLib/reference/FE8U-decompatible.o

# OBJ to event
%.lyn.event: %.o $(LYN_REFERENCE)
	$(NOTIFY_PROCESS)
	@$(LYN) $< $(LYN_REFERENCE) > $@

# OBJ to DMP rule
%.dmp: %.o
	$(NOTIFY_PROCESS)
	@$(OBJCOPY) -S $< -O binary $@

# ========================
# = ASSEMBLY/COMPILATION =
# ========================

# Setting C/ASM include directories up (there is none yet)
INCLUDE_DIRS := Tools/CLib/include Wizardry/Include
INCFLAGS     := $(foreach dir, $(INCLUDE_DIRS), -I "$(dir)")

# setting up compilation flags
ARCH    := -mcpu=arm7tdmi -mthumb -mthumb-interwork
CFLAGS  := $(ARCH) $(INCFLAGS) -Wall -Os -mtune=arm7tdmi -ffreestanding -mlong-calls -fno-jump-tables
ASFLAGS := $(ARCH) $(INCFLAGS)

# defining dependency flags
CDEPFLAGS = -MMD -MT "$*.o" -MT "$*.asm" -MF "$(CACHE_DIR)/$(notdir $*).d" -MP
SDEPFLAGS = --MD "$(CACHE_DIR)/$(notdir $*).d"

# ASM to OBJ rule
%.o: %.s
	$(NOTIFY_PROCESS)
	@$(AS) $(ASFLAGS) $(SDEPFLAGS) -I $(dir $<) $< -o $@ $(ERROR_FILTER)

# C to ASM rule
# I would be fine with generating an intermediate .s file but this breaks dependencies
%.o: %.c
	$(NOTIFY_PROCESS)
	@$(CC) $(CFLAGS) $(CDEPFLAGS) -g -c $< -o $@ $(ERROR_FILTER)

# C to ASM rule
%.asm: %.c
	$(NOTIFY_PROCESS)
	@$(CC) $(CFLAGS) $(CDEPFLAGS) -S $< -o $@ -fverbose-asm $(ERROR_FILTER)

# Avoid make deleting objects it thinks it doesn't need anymore
# Without this make may fail to detect some files as being up to date
.PRECIOUS: %.o;

# ==============
# = MAKE CLEAN =
# ==============

ifeq ($(MAKECMDGOALS),clean)

  # ASM/C and generated files
  CFILES := $(shell find -type f -name '*.c')
  SFILES := $(shell find -type f -name '*.s')

  ASM_C_GENERATED := $(CFILES:.c=.o) $(SFILES:.s=.o) $(CFILES:.c=.asm)
  ASM_C_GENERATED += $(ASM_C_GENERATED:.o=.dmp) $(ASM_C_GENERATED:.o=.lyn.event)

  CLEAN_FILES += $(ASM_C_GENERATED)

endif
