
# =============
# = PORTRAITS =
# =============

PORTRAIT_LIST      := Graphics/PortraitList.txt
PORTRAIT_INSTALLER := Graphics/GraphicsInstaller.event

# Make the portrait installer
$(PORTRAIT_INSTALLER): $(PORTRAIT_LIST) $(shell $(PORTRAIT_PROCESS) $(PORTRAIT_LIST) --list-files)
	$(NOTIFY_PROCESS)
	@$(PORTRAIT_PROCESS) $< --output $@

# Convert a png to portrait components
%_mug.dmp %_palette.dmp %_frames.dmp %_minimug.dmp: %.png
	$(NOTIFY_PROCESS)
	@$(PORTRAITFORMATTER) $<

# ==========================
# = GRAPHICS & COMPRESSION =
# ==========================

# PNG to 4bpp rule
%.4bpp: %.png
	$(NOTIFY_PROCESS)
	@$(PNG2DMP) $< -o $@

# PNG to gbapal rule
%.gbapal: %.png
	$(NOTIFY_PROCESS)
	@$(PNG2DMP) $< -po $@ --palette-only

# Anything to lz rule
%.lz: %
	$(NOTIFY_PROCESS)
	@$(COMPRESS) $< $@

ifeq ($(MAKECMDGOALS),clean)

  # Portraits and generated files
  PORTRAITS := $(wildcard Graphics/Portraits/*.png)

  PORTRAIT_GENERATED := \
    $(PORTRAITS:.png=_mug.dmp) $(PORTRAITS:.png=_palette.dmp) \
    $(PORTRAITS:.png=_frames.dmp) $(PORTRAITS:.png=_minimug.dmp)

  CLEAN_FILES += $(PORTRAIT_INSTALLER) $(PORTRAIT_GENERATED)

endif
