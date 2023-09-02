.SUFFIXES:
.PHONY: all patch rom objects asmgen bindmps clean

# making sure devkitARM exists and is set up
ifeq ($(strip $(DEVKITARM)),)
	$(error "Please set DEVKITARM in your environment. export DEVKITARM=<path to>devkitARM")
endif

# including devkitARM tool definitions
include $(DEVKITARM)/base_tools
# include src/tonc_rules

# setting up main dir
# we want to use an absolute path because EA's wd won't be here
ABS_MAIN_DIR := $(realpath .)
MAIN_DIR := .

# Setting C/ASM include directories up
INCLUDE_DIRS := $(MAIN_DIR)/src/libgbafe
INCFLAGS     := $(foreach dir, $(INCLUDE_DIRS), -I "$(dir)")

# adding local binaries to path
PATH := $(abspath .)/bin:$(PATH)

ROMNAME := FlierEmblem
ROM := $(MAIN_DIR)/$(ROMNAME).gba
UPS := $(ROM:.gba=.ups)
BUILDFILE := $(MAIN_DIR)/ROMBuildfile.event

# lyn library object
LYNLIB := $(MAIN_DIR)/src/libgbafe/fe8u.o

# setting up compilation flags
ARCH    := -mcpu=arm7tdmi -mthumb -mthumb-interwork
CFLAGS  := $(ARCH) $(INCFLAGS) -Os -mtune=arm7tdmi -fomit-frame-pointer -ffast-math -fno-jump-tables -w
ASFLAGS := $(ARCH) $(INCFLAGS)
CARMFLAGS:= -mcpu=arm7tdmi -marm -mthumb-interwork $(INCFLAGS) -Ofast -mtune=arm7tdmi -fomit-frame-pointer -ffast-math -fno-jump-tables -w -mlong-calls

# dependency generation flags for CC
CDEPFLAGS = -MD -MT $*.o -MT $*.asm -MF $*.d -MP

# find EA dependencies
EA_DIR := $(MAIN_DIR)/EventAssembler
CLEANROM := $(MAIN_DIR)/FE8_Clean.gba
CORE := $(EA_DIR)/ColorzCore
COREFLAGS := A FE8 "-output:$(ROM)" "-input:$(BUILDFILE)" --nocash-sym
EADEP := $(EA_DIR)/ea-dep
EADEPFLAGS = --add-missings --add-externals

#Text
TEXT := $(MAIN_DIR)/Text/InstallTextData.text.event

# Finding all possible source files (in src folder)
ARMASMFILES := $(shell find arm/ -type f -name '*.arm.asm')
ARMCFILES := $(shell find arm/ -type f -name '*.arm.c')
CFILES := $(shell find src/ -type f -name '*.c')
SFILES := $(shell find src/ -type f -name '*.s')

# #getting the possible ARM asm files
# ARMFILES := $(ARMCFILES:.arm.c=.arm.asm)

# listing possible object files
OFILES := $(CFILES:.c=.o) $(SFILES:.s=.o)

# listing possible generated asm files
ASMFILES := $(CFILES:.c=.asm) $(ARMCFILES:.arm.c=.arm.asm)

LASMFILES := $(ARMCFILES:.arm.c=.arm.lyn.event) $(ARMASMFILES:.arm.asm=.arm.lyn.event)

# listing possible lyn event files
LYNFILES := $(OFILES:.o=.lyn.event)

# listing possible dmp files
DMPFILES := $(OFILES:.o=.dmp)

# listing possible dependency files
DEPFILES := $(CFILES:.c=.d)

# defining & making dependency directory
DEPSDIR := .MkDeps
$(shell mkdir -p $(DEPSDIR) > /dev/null)

# listing possible dependency files
DEPFILES := $(addprefix $(DEPSDIR)/, $(notdir $(CFILES:.c=.d)))

# dependency generation flags for CC
CDEPFLAGS = -MD -MT $*.o -MT $*.asm -MF $(DEPSDIR)/$(notdir $*).d -MP

EDEPS := $(EADEP) $(BUILDFILE) $(EADEPFLAGS)

#special arm file rules
$(ROM): $(CLEANROM) $(BUILDFILE) $(LASMFILES) $(LYNFILES) $(OFILES) $(ASMFILES) 
	$(shell cp $< $@)
	$(CORE) $(COREFLAGS)

%.arm.lyn.event: %.arm.event
	@echo "$(notdir $<) => $(notdir $@)"
	@py $(MAIN_DIR)/scripts/clean_lyn_arm.py $< $@

%.arm.event: %.arm.elf
	@echo "$(notdir $<) => $(notdir $@)"
	@lyn $< > $@

%.arm.elf: %.arm.asm
	@echo "$(notdir $<) => $(notdir $@)"
	@$(AS) -g -mcpu=arm7tdmi $< -o $@

%.arm.asm: %.arm.c
	@echo "$(notdir $<) => $(notdir $@)"
	@$(CC) $(CARMFLAGS) $(CDEPFLAGS) -S $< -o $@ -fno-toplevel-reorder -fverbose-asm $(ERROR_FILTER)

# C to ASM rule
%.asm: %.c
	@echo "$(notdir $<) => $(notdir $@)"
	@$(CC) $(CFLAGS) $(CDEPFLAGS) -S $< -o $@ -fverbose-asm $(ERROR_FILTER)

# C to OBJ rule
%.o: %.c
	@echo "$(notdir $<) => $(notdir $@)"
	@$(CC) $(CFLAGS) $(CDEPFLAGS) -c $< -o $@ $(ERROR_FILTER)

# OBJ to DMP rule
%.dmp: %.o
	@echo "$(notdir $<) => $(notdir $@)"
	@$(OBJCOPY) -S $< -O binary $@

# OBJ to EVENT rule
%.lyn.event: %.o $(LYNLIB)
	@echo "$(notdir $<) => $(notdir $@)"
	@lyn $< $(LYNLIB) > $@

%.text.event: $(MAIN_DIR)/Text/text_buildfile.txt
	@python 'scripts/textprocess_v2.py' $<

# ASM to OBJ
%.o: %.s
	@echo "$(notdir $<) => $(notdir $@)"
	@$(AS) $(ARCH) $< -o $@ $(ERROR_FILTER)

all: /Text/InstallTextData.text.event $(LASMFILES) $(LYNFILES) $(DMPFILES) $(UPS)

# "make all" phony targets
patch: $(UPS);
# UPS rule
$(UPS): $(ROM)
	ups/ups diff -b $(CLEANROM) -m $< -o $@
rom: $(ROM)
objects: $(OFILES);
asmgen: $(ASMFILES);
events: $(LYNFILES);
bindmps: $(DMPFILES);
arm: $(LASMFILES);
text: $(Text)

# "Clean" target
clean:
	@rm -f $(OFILES) $(LASMFILES) $(ASMFILES) $(LYNFILES) $(DMPFILES) $(DEPFILES) $(ROM) $(UPS) $(TEXT) Text/_textentries/*
	@echo done.

-include $(DEPFILES)
