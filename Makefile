
.SUFFIXES:
.PHONY:

# EA Input File
EVENT_MAIN := ROMBuildfile.event

# ROMs
ROM_SOURCE := FE8_Clean.gba
ROM_TARGET := FE8Hack.gba


%.dmp:
    : do nothing for $@
%.bin:
    : do nothing for $@


include Tools/tools.mk

# Common cache directory
# Used to generate dependency files in
CACHE_DIR := .cache_dir
$(shell mkdir -p $(CACHE_DIR) > /dev/null)

CLEAN_FILES :=
CLEAN_DIRS  :=

# ===============
# = MAIN TARGET =
# ===============

hack: $(ROM_TARGET)

.PHONY: hack

# =================
# = THE BUILDFILE =
# =================

# EA depends
EVENT_DEPENDS := $(shell $(EADEP) $(EVENT_MAIN) -I $(realpath .)/Tools/EventAssembler --add-missings)

# Additional EA commandline flags
# EAFLAGS := -raws:Tools/EA-Raws --nocash-sym
EAFLAGS := --nocash-sym

$(ROM_TARGET): $(EVENT_MAIN) $(EVENT_DEPENDS) $(ROM_SOURCE)
	$(NOTIFY_PROCESS)
	@cp -f $(ROM_SOURCE) $(ROM_TARGET)
	@$(EA) A FE8 -output:$(ROM_TARGET) -input:$(EVENT_MAIN) $(EAFLAGS) || (rm $(ROM_TARGET) && false)
	@cat "$(ROM_SOURCE:.gba=.sym)" >> "$(ROM_TARGET:.gba=.sym)" || true

ifeq ($(MAKECMDGOALS),clean)
  CLEAN_FILES += $(ROM_TARGET) $(ROM_TARGET:.gba=.sym) $(EVENT_SYMBOLS)
endif

# ===================
# = COMPONENT RULES =
# ===================

# include Tools/spritans.mk
# include Tools/writans.mk
# include Tools/game-data.mk
# include Tools/wizardry.mk

# ==============
# = MAKE CLEAN =
# ==============

clean:
	@rm -f $(CLEAN_FILES)
	@rm -rf $(CLEAN_DIRS)
	@rm -rf $(CACHE_DIR)

	@echo all clean!

.PHONY: clean

# ========================
# = INCLUDE DEPENDENCIES =
# ========================

ifneq ($(MAKECMDGOALS),clean)
  -include $(wildcard $(CACHE_DIR)/*.d)
endif
