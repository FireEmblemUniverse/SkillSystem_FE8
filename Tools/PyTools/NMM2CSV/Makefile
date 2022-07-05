.PHONY: dist clean

ifndef DIST_DIR
 # Set default release directory
 DIST_DIR := ReleaseDist
endif

dist: c2ea.py n2c.py icon.ico
	mkdir -p "$(DIST_DIR)"
	pyinstaller -F --distpath "$(DIST_DIR)" --icon=icon.ico c2ea.py
	pyinstaller -F --distpath "$(DIST_DIR)" --icon=icon.ico n2c.py
	cp -f "Readme.md" "$(DIST_DIR)/Readme.md"
	cp -f "Table Definitions.txt" "$(DIST_DIR)/Table Definitions.txt"

clean:
	rm -rf $(DIST_DIR)
