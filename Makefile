# DIRECTORIES
TOOLSDIR = tools
DECOMPDIR = decomp
ASMDIR = $(DECOMPDIR)/asm
CDIR = $(DECOMPDIR)/src
BINDIR = $(DECOMPDIR)/assets

# FILES
ROMFILE = baserom.us.z64
SPLITFILE = snowboardkids.yaml

# TOOLS
SPLATDIR = $(TOOLSDIR)/splat
SPLAT = $(SPLATDIR)/split.py

M2C_DIR = $(TOOLSDIR)/m2c
M2C = $(M2C_DIR)/m2c.py

# TERMINAL COLORS: https://man7.org/linux/man-pages/man5/terminal-colors.d.5.html
CRESET = \e[0m
CGREEN = \e[32m
CRED = \e[31m
CBLUE = \e[34m
CHIGHLIGHT = \e[1m
CCOMMAND = \e[36m

define print_info
	@echo "$(CBLUE)$(1)$(CRESET)"
endef

.PHONY: clean splat tools decomp check-requirements check-git check-python3

tools: $(SPLAT) $(M2C)

check-requirements: check-git check-python3

check-git:
	@which git > /dev/null && echo "$(CGREEN)git found$(CRESET)" || { echo "$(CRED)git not found.$(CRESET) $(CHIGHLIGHT)Please install git on your system.$(CRESET)"; exit 1; }

check-python3:
	@which python3 > /dev/null && echo "$(CGREEN)python3 found$(CRESET)" || { echo "$(CRED)python3 not found.$(CRESET) $(CHIGHLIGHT)Please install python3 on your system.$(CRESET)"; exit 1; }
	@which pip3 > /dev/null && echo "$(CGREEN)pip3 found$(CRESET)" || { echo "$(CRED)pip3 not found.$(CRESET) $(CHIGHLIGHT)Please install pip3 on your system.$(CRESET)"; exit 1; }

$(M2C):
	$(call print_info,Downloading m2c)
	git clone https://github.com/matt-kempster/m2c.git $(M2C_DIR)

$(SPLAT):
	$(call print_info,Downloading splat)
	git clone https://github.com/ethteck/splat.git $(SPLATDIR)
	$(call print_info,Installing splat requirements)
	pip3 install -r $(SPLATDIR)/requirements.txt

clean:
	rm -rf $(DECOMPDIR)

decomp: check-requirements splat $(M2C)
	$(call print_info,Converting ASM to C)

splat: $(ROMFILE) $(SPLAT)
	$(call print_info,Extracting ASM from ROM file)
	$(SPLAT) $(SPLITFILE)
