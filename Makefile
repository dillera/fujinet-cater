# Makefile for CATER 2024
# this is using the local makefiles, copied from the fujinet-build-tools/makefiles 
# based on the work done by fenrock but not supported by him

# Set the TARGETS and PROGRAM values as required.
TARGETS = apple2enh atari
PROGRAM := cater

SUB_TASKS := clean disk test release
.PHONY: all help $(SUB_TASKS)

# Set the FUJINET_BUILD_TOOLS_DIR to be the same directory as we are in now....
export FUJINET_BUILD_TOOLS_DIR := .
export FUJINET_LIB_VERSION := 4.3.1

all:
	@for target in $(TARGETS); do \
		echo "-------------------------------------"; \
		echo "Building $$target"; \
		echo "-------------------------------------"; \
		$(MAKE) --no-print-directory -f $(FUJINET_BUILD_TOOLS_DIR)/makefiles/build.mk CURRENT_TARGET=$$target PROGRAM=$(PROGRAM) $(MAKECMDGOALS); \
	done

$(SUB_TASKS): _do_all
$(SUB_TASKS):
	@:

_do_all: all


help:
	@echo "Makefile for $(PROGRAM)"
	@echo ""
	@echo "Available tasks:"
	@echo "all       - do all compilation tasks, create app in build directory"
	@echo "clean     - remove all build artifacts"
	@echo "disk      - generate platform specific disk versions of application (PO/ATR etc)"
	@echo "test      - run application in emulator for given platform."
	@echo "            specific platforms may expose additional variables to run with"
	@echo "            different emulators, see makefiles/custom-<platform>.mk"
	@echo "release   - create a release of the executable in the dist/ dir"
