.PHONY: dist clean

ifndef DIST_DIR
 # Set default release directory
 DIST_DIR := ReleaseDist
endif

dist: tmx2ea.py icon.ico
	mkdir -p "$(DIST_DIR)"
	pyinstaller -F --distpath "$(DIST_DIR)" --icon=icon.ico tmx2ea.py
	cp -f "README.md" "$(DIST_DIR)/README.md"

clean:
	rm -rf $(DIST_DIR)
