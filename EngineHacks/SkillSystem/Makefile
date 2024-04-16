
CACHE_DIR := .cache_dir
$(shell mkdir -p $(CACHE_DIR) > /dev/null)

TOOL_DIR := ../../Tools
LIB_DIR  := $(TOOL_DIR)/FE-CLib
HAX_DIR  := ./

FE8_REF := $(LIB_DIR)/reference/fireemblem8.ref.s

CLEAN_FILES :=
CLEAN_DIRS  := $(CACHE_DIR)

# =========
# = Tools =
# =========
ifeq ($(OS),Windows_NT)
  EXE := .exe
else
  EXE :=
endif

PREFIX  ?= C:/devkitPro/devkitARM/bin/arm-none-eabi-
CC      := $(PREFIX)gcc$(EXE)
AS      := $(PREFIX)as$(EXE)
OBJCOPY := $(PREFIX)objcopy$(EXE)

EA_DIR  := ../../EventAssembler
EA_DEP  := $(TOOL_DIR)/ea-dep/ea-dep$(EXE)
MAIN    := ./SkillSystemInstaller.event
LYN     := $(EA_DIR)/Tools/lyn$(EXE)

DUMMY_INC := $(TOOL_DIR)/ea-dep

# ============
# = MAKE HAX =
# ============
MAIN_DEPS := $(shell $(EA_DEP) $(MAIN) -I $(EA_DIR))

default: $(MAIN_DEPS)

# ============
# = Wizardry =
# ============

INC_DIRS := include $(LIB_DIR)/include $(DUMMY_INC)
INC_FLAG := $(foreach dir, $(INC_DIRS), -I $(dir))

ARCH    := -mcpu=arm7tdmi -mthumb -mthumb-interwork
CFLAGS  := $(ARCH) $(INC_FLAG) -Wall -Wextra -Wno-unused-parameter -O2 -mtune=arm7tdmi -mlong-calls
ASFLAGS := $(ARCH) $(INC_FLAG)

CDEPFLAGS = -MMD -MT "$*.o" -MT "$*.asm" -MF "$(CACHE_DIR)/$(notdir $*).d" -MP
SDEPFLAGS = --MD "$(CACHE_DIR)/$(notdir $*).d"

LYN_REF := $(CACHE_DIR)/lyn-ref.o

$(LYN_REF): $(FE8_REF)
	@echo "[AS ]	$@"
	@cp $(FE8_REF) $(LYN_REF:.o=.s)
	@$(AS) $(LYN_REF:.o=.s) -o $@
	
SKILLSYS_REF := $(CACHE_DIR)/skillsys-ref.o
	
$(SKILLSYS_REF) : ./skillsys-ref.s
	@echo "[AS ]	$@"
	@cp ./skillsys-ref.s $(SKILLSYS_REF:.o=.s)
	@$(AS) $(SKILLSYS_REF:.o=.s) -o $@

# Build rules

#.o to .lyn.event rule	
%.lyn.event: %.o $(LYN_REF) $(SKILLSYS_REF)
	@echo "[LYN]	$@"
	@$(LYN) $< $(LYN_REF) $(SKILLSYS_REF) > $@

#.o to .dmp rule
%.dmp: %.o
	@echo "[GEN]	$@"
	@$(OBJCOPY) -S $< -O binary $@

%.o: %.s
	@echo "[AS ]	$@"
	@$(AS) $(ASFLAGS) $(SDEPFLAGS) -I $(dir $<) $< -o $@

%.o: %.c
	@echo "[CC ]	$@"
	@$(CC) $(CFLAGS) $(CDEPFLAGS) -g -c $< -o $@

%.s: %.c
	@echo "[CC ]	$@"
	@$(CC) $(CFLAGS) $(CDEPFLAGS) -S $< -o $@ -fverbose-asm
	
# Avoid make deleting objects it thinks it doesn't need anymore
# Without this make may fail to detect some files as being up to date
#.PRECIOUS: %.o;

-include $(wildcard $(CACHE_DIR)/*.d)

CFILES := $(shell find $(HAX_DIR) -type f -name '*.c')
CLEAN_FILES += $(CFILES:.c=.o)

LYN_EVENTS := $(CFILES:.c=.lyn.event)

# ==============
# = MAKE CLEAN =
# ==============
clean:
	@rm -f $(CLEAN_FILES)
	@rm -rf $(CLEAN_DIRS)
	@echo "[RM]	$(notdir $(CLEAN_FILES)) $(notdir $(CLEAN_DIRS))"



