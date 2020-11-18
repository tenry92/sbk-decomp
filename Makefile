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
MIPS_TO_C = $(MIPS_TO_C_DIR)/mips_to_c.py

N64SPLATDIR = $(TOOLSDIR)/n64splat
N64SPLAT = $(N64SPLATDIR)/split.py


.PHONY: clean split tools decomp

tools: $(N64SPLIT) $(MIPS_TO_C)

$(N64SPLIT):
	git clone --recurse-submodules -j8 https://github.com/queueRAM/sm64tools.git $(SM64TOOLSDIR)
	cd $(SM64TOOLSDIR) && make

$(MIPS_TO_C):
	git clone https://github.com/matt-kempster/mips_to_c.git $(MIPS_TO_C_DIR)

$(N64SPLAT):
	git clone https://github.com/ethteck/n64splat.git $(N64SPLATDIR)

clean:
	rm -rf $(DECOMPDIR)

decomp: $(ASMFILE) $(MIPS_TO_C)
	@mkdir -p $(CDIR) $(ASMDIR)
	@MIPS_TO_C=$(MIPS_TO_C) $(TOOLSDIR)/decomp.sh $(ASMFILE) $(ASMDIR) $(CDIR)

$(ASMFILE): split

split: $(ROMFILE) $(N64SPLIT)
	$(N64SPLIT) -c $(SPLITFILE) -o $(DECOMPDIR) $(ROMFILE)
	rmdir $(DECOMPDIR)/geo $(DECOMPDIR)/levels
	sed -i 's/mips64-elf-/mips-linux-gnu-/' $(DECOMPDIR)/Makefile
	sed -i 's+OUTPUT_FORMAT.*+/* \0 */+' $(DECOMPDIR)/snowboard_kids.u.ld
	sed -i 's+TOOLS_DIR = ../tools+TOOLS_DIR = ../sm64tools+' $(DECOMPDIR)/Makefile
