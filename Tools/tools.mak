# making sure devkitARM exists and is set up
ifeq ($(strip $(DEVKITARM)),)
	$(error "Please set DEVKITARM in your environment. export DEVKITARM=<path to>devkitARM")
endif

# including devkitARM tool definitions
include $(DEVKITARM)/base_tools

# setting up additional path
export PATH := $(abspath .)/bin:$(PATH)

# setting up additional tools
# right now integrating EA is kind of a mess, so we use a trampoline shell script that changes the working directory
export EA  := ea
export PEA := pea
export LYN := lyn

PREPROCESS_MESSAGE = @echo "$(notdir $<) => $(notdir $@)"
