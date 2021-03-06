#!/bin/bash

ASMFILE=$1
ASMDIR=$2
CDIR=$3

function decompile-lines {
  LINESTART=$1
  LINEEND=$2
  NAME=$(sed -n "$LINESTART,${LINESTART}p" $ASMFILE | tr -d :)
  
  echo "translating $NAME into C..."
  
  sed -n "$LINESTART,${LINEEND}p" $ASMFILE > $NAME.s
  $MIPS_TO_C $NAME.s > $CDIR/$NAME.c
  RET=$?
  rm $NAME.s
  
  if [ $RET -eq 1 ]; then
    cat $CDIR/$NAME.c
    rm $CDIR/$NAME.c
    return $RET
  fi
}

function decompile-offsets {
  START=$1
  END=$2
  
  LINESTART=$(awk "/\/\* $START/{ print NR - 1; exit }" "$ASMFILE")
  LINEEND=$(awk "/\/\* $END/{ print NR; exit }" "$ASMFILE")
  
  decompile-lines $LINESTART $LINEEND
  
  return $?
}

function copy-asm-offsets {
  START=$1
  END=$2
  
  LINESTART=$(awk "/\/\* $START/{ print NR - 1; exit }" "$ASMFILE")
  LINEEND=$(awk "/\/\* $END/{ print NR; exit }" "$ASMFILE")
  
  NAME=$(sed -n "$LINESTART,${LINESTART}p" $ASMFILE | tr -d :)
  
  echo "copying $NAME..."
  
  sed -n "$LINESTART,${LINEEND}p" $ASMFILE > $ASMDIR/$NAME.s
  return $?
}

function insert-nop {
  LABEL=$1
  sed "s+$LABEL:+$LABEL:\n/* REMOVE ME */ nop+" $ASMFILE > tmp.s
  mv tmp.s $ASMFILE
}

function remove-fix-nops {
  sed ':a;N;$!ba;s+\n/\* REMOVE ME \*/ nop++g' $ASMFILE > tmp.s
  mv tmp.s $ASMFILE
}

decompile-offsets 001050 0011E0 # func_80000450
copy-asm-offsets  0011E4 00155C # thread4
decompile-offsets 001560 0017FC # func_80000960 func_800009B0 func_80000A40 func_80000A8C
decompile-offsets 001894 0019B0 # func_80000C94 (init controller pak)
decompile-offsets 001A00 001C0C # func_80000E00 (find save file)
insert-nop .L800012A4 && decompile-offsets 001C5C 001EC8 # func_8000105C (read/write save file)
decompile-offsets 001F18 002134 # func_80001318 (find/create save file)

decompile-offsets 002184 002214 # func_80001584 (init controller pak)
decompile-offsets 00225C 0022D4 # func_8000165C
decompile-offsets 002324 002454 # func_80001724 (delete save file)
decompile-offsets 00249C 002500 # func_8000189C (check controller pak free blocks)

decompile-offsets 0437C0 04381C # func_80042BC0
decompile-offsets 043828 043924 # func_80042C28 func_80042CDC
decompile-offsets 043958 043AE0 # func_80042D58
decompile-offsets 0464E0 046510 # func_800458E0
decompile-offsets 048F38 048F84 # func_80048338 func_8004835C
decompile-offsets 0490F0 049120 # func_800484F0

decompile-offsets 0710F0 071210 # func_800704F0
decompile-offsets 072430 072770 # func_80071830 func_80071A3C func_80071A8C
decompile-offsets 0727B0 0727E4 # func_80071BB0
decompile-offsets 0727E8 072880 # func_80071BE8
decompile-offsets 0728C0 072CE0 # func_80071CC0 func_80071E80
decompile-offsets 072DB8 072E5C # func_800721B8
decompile-offsets 072EB4 0734DC # func_800722B4 func_800722F0 func_80072518 func_8007276C func_80072844
copy-asm-offsets  073724 073824 # func_80072B24

decompile-offsets 099980 099E84 # func_80098D80 func_80098EAC
decompile-offsets 09A0F4 09A148 # func_800994F4
decompile-offsets 09A2A0 09A4E0 # main main_thread func_80099790
copy-asm-offsets  09A4E4 09A800 # thread2
decompile-offsets 09BCE8 09C188 # func_8009B0E8 func_8009B14C
decompile-offsets 099E88 099F80 # func_80099288
decompile-offsets 09C304 09CE68 # func_8009B704
decompile-offsets 09CE70 09D030 # func_8009C270
decompile-offsets 09D044 09D6B0 # thread5 func_8009C6DC func_8009C77C func_8009C81C thread6 func_8009CA60
decompile-offsets 09D744 09D89C # func_8009CB44 func_8009CB98 func_8009CC50
decompile-offsets 09E95C 09E9E0 # func_8009DD5C
decompile-offsets 09EAC4 09EB10 # func_8009DEC4

decompile-offsets 0A0E90 0A0EB8 # func_800A0290
decompile-offsets 0A1C20 0A1DBC # func_800A1020
decompile-offsets 0A51A0 0A54F0 # func_800A45A0 thread7
decompile-offsets 0A55E0 0A5604 # func_800A49E0

remove-fix-nops


#######################
# MAKE C CODE CLEANER

function p {
  BASENAME=$1
  SRCFILE=$CDIR/$BASENAME
  COPY=$SRCFILE.orig
  PATCHFILE=patches/src/$BASENAME.patch
  
  cp $SRCFILE $COPY
  patch $SRCFILE $PATCHFILE
}

p main.c
p thread5.c
p func_8009C270.c
p func_8009CB44.c
