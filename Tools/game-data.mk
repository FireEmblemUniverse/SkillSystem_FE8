
# ==========
# = TABLES =
# ==========

# Convert CSV+NMM to event
%.event: %.csv %.nmm
	$(NOTIFY_PROCESS)
	@echo | $(C2EA) -csv $*.csv -nmm $*.nmm -out $*.event $(ROM_SOURCE) > /dev/null

# ========
# = MAPS =
# ========

# TMX to event + dmp
%.event %_data.dmp: %.tmx
	$(NOTIFY_PROCESS)
	@echo | $(TMX2EA) $< > /dev/null

# ==============
# = MAKE CLEAN =
# ==============

ifeq ($(MAKECMDGOALS),clean)

  # NMMs and generated events
  NMMS := $(shell find -type f -name '*.nmm')
  TABLE_EVENTS := $(NMMS:.nmm=.event)

  # TMXs and generated files
  TMXS := $(shell find -type f -name '*.tmx')
  MAP_GENERATED := $(TMXS:.tmx=.event) $(TMXS:.tmx=_data.dmp)

  CLEAN_FILES += $(TABLE_EVENTS) $(MAP_GENERATED)

endif
