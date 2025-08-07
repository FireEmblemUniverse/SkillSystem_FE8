# Paths
FORMATTER = python Sommie.py
SRC_DIR = data

# Find all .png files recursively
SRC = $(shell find $(SRC_DIR) -type f -name "*.png")
IMG = $(patsubst %.png, %.dmp, $(SRC))
PALETTE = $(patsubst %.png, %Pal.dmp, $(SRC))
OBJ = $(IMG) $(PALETTE)

# Default target
all: $(OBJ)

# Rule to process images
%.dmp %.Pal.dmp: %.png
	@echo "Processing $<"
	$(FORMATTER) 224 "$<" "$(basename $<).dmp" "$(basename $<)Pal.dmp"

# Clean up generated files
clean:
	find $(SRC_DIR) -type f -name "*.dmp" -delete

.PHONY: all clean