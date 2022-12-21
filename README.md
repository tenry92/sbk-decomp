# Snowboard Kids Decompilation Project

This project tries to create an exact decompilation of the Nintendo 64 game
Snowboard Kids. The goal is to have (almost) all code in well written C files
and assets such as textures, models, sounds and music sequences in separate
files, allowing anybody to change something here and there and recreate a fully
functional N64 ROM file from these files. If no changes were done to any of the
individual files, the resulting ROM file shall completely match the original
ROM file it was decompiled from.

This project still is in a very early process and does not allow re-creating
a ROM file yet.

## About Snowboard Kids

Snowboard Kids is a fun racer game for N64 developed by Racdym. The following
versions of the original game were published:

- NTSC Japanese: December 12, 1997
- NTSC North America: February 1998
- PAL: March 16, 1998

An enhanced port named Snowboard Kids Plus was also released for the PlayStation
in January 21, 1999 in Japan only.
This version includes changed a title screen, updated menus, additional
characters and animated video sequences.

The sequel Snowboard Kids 2 was later also published for the N64, which is
probably based on the same game engine.

## Project structure

- decomp/ *generated*
  - asm/ *ASM code*
  - assets/ *binary assets that should include everything but code*
  - src/ *C code converted from assembly*
- tools/
    - m2c/ *automatically downloaded*
    - splat/ *automatically downloaded*
- Makefile
- baserom.us.z64 *← YOU put this file here*
- calltree.txt
- snowboardkids.yaml *ROM data locations*
- symbol_addrs.txt

## Decompilation process

This project is currently developed in Linux. It makes extensive use of Linux
command line tools.

Put a ROM of Snowboard Kids (US) into this base folder and name it
**baserom.us.z64**. The *sha1sum* should be
**1583bacc9046a360df8ea4d536942155247e154c**. If this is not the case, you might
need to byteswap the file. Otherwise, you seem to have a different version of
the game.

Call `make decomp` for creating a (work in progress) decompilation of your ROM
into a new folder `decomp`.
