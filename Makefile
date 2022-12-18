# DIRECTORIES
TOOLSDIR = tools
DECOMPDIR = decomp
ASMDIR = $(DECOMPDIR)/asm
CDIR = $(DECOMPDIR)/src
BINDIR = $(DECOMPDIR)/bin

# FILES
ROMFILE = baserom.us.z64
SPLITFILE = snowboard_kids.u.yaml
ASMFILE = $(DECOMPDIR)/snowboard_kids.u.s

# TOOLS
SM64TOOLSDIR = $(TOOLSDIR)/sm64tools
N64SPLIT = $(SM64TOOLSDIR)/n64split

MIPS_TO_C_DIR = $(TOOLSDIR)/mips_to_c
MIPS_TO_C = $(MIPS_TO_C_DIR)/m2c.py

N64SPLATDIR = $(TOOLSDIR)/n64splat
N64SPLAT = $(N64SPLATDIR)/split.py

# TERMINAL COLORS: https://man7.org/linux/man-pages/man5/terminal-colors.d.5.html
CRESET = \e[0m
CGREEN = \e[32m
CRED = \e[31m
CHIGHLIGHT = \e[1m
CCOMMAND = \e[36m


.PHONY: clean split tools decomp check-requirements check-git check-python3

tools: $(N64SPLIT) $(MIPS_TO_C)

check-requirements: check-git check-python3

check-git:
	@which git > /dev/null && echo "$(CGREEN)git found$(CRESET)" || { echo "$(CRED)git not found.$(CRESET) $(CHIGHLIGHT)Please install git on your system.$(CRESET)"; exit 1; }

check-python3:
	@which python3 > /dev/null && echo "$(CGREEN)python3 found$(CRESET)" || { echo "$(CRED)python3 not found.$(CRESET) $(CHIGHLIGHT)Please install python3 on your system.$(CRESET)"; exit 1; }
	@python3 -m pip show pycparser -q && echo "$(CGREEN)python package pycparser found$(CRESET)" || { echo "$(CHIGHLIGHT)Please install the package using the following command:$(CRESET) $(CCOMMAND)python3 -m pip install --upgrade pycparser$(CRESET)"; exit 1; }

$(N64SPLIT):
	git clone --recurse-submodules -j8 https://github.com/queueRAM/sm64tools.git $(SM64TOOLSDIR)
	cd $(SM64TOOLSDIR) && make

$(MIPS_TO_C):
	git clone https://github.com/matt-kempster/m2c.git $(MIPS_TO_C_DIR)

$(N64SPLAT):
	git clone https://github.com/ethteck/n64splat.git $(N64SPLATDIR)

clean:
	rm -rf $(DECOMPDIR)

decomp: $(ASMFILE) $(MIPS_TO_C) check-requirements
	@mkdir -p $(CDIR) $(ASMDIR)
	@MIPS_TO_C=$(MIPS_TO_C) $(TOOLSDIR)/decomp.sh $(ASMFILE) $(ASMDIR) $(CDIR)

$(ASMFILE): split

split: $(ROMFILE) $(N64SPLIT)
	$(N64SPLIT) -c $(SPLITFILE) -o $(DECOMPDIR) $(ROMFILE)
	rmdir $(DECOMPDIR)/geo $(DECOMPDIR)/levels
	sed -i 's/mips64-elf-/mips-linux-gnu-/' $(DECOMPDIR)/Makefile
	sed -i 's+OUTPUT_FORMAT.*+/* \0 */+' $(DECOMPDIR)/snowboard_kids.u.ld
	sed -i 's+TOOLS_DIR = ../tools+TOOLS_DIR = ../sm64tools+' $(DECOMPDIR)/Makefile
