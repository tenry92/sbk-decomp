s32         D_800B30F0;
s8          D_800DEED8[1];
            D_800E0080;
OSThread    gThread4; /* 0x800E29C8 */
OSMesgQueue gThread4MsgQueue /* 0x800E4B78 */
OSMesgQueue gUnkMsgQueue800E4BB0; /* 0x800E4BB0 */
OSMesgQueue gUnkMsgQueue800E4BD0; /* 0x800E4BD0 */
extern OSViMode osViModeTable[];  /* 0x800DF340 */
OSMesgQueue gUnkMsgQueue80123FF8; /* 0x80123FF8 */
OSMesgQueue gUnkMsgQueue80124018; /* 0x80124018 */
OSMesgQueue gUnkMsgQueue80124050; /* 0x80124050 */
OSMesgQueue gUnkMsgQueue80124070; /* 0x80124070 */

u8          D_800E4BEE;
u16         D_800E4BEC;

OSContPad   D_800E4C00;

struct {
  s32 unk0;
  u8 unk2;
  s32 unk3;
}           D_800E4C18;
u8          D_800E4C21;
u16         D_800E4C1B;
u16         D_800E4C1E;
u16         D_800E4C27;
u16         D_800E4C2D;
u8          D_800EC8B0;

u8          D_8010ADFA;

struct {
  s8 unk10;
}           D_80110198;
void       *D_801101AC;
struct {
  void *unk0; /* refers to D_80110198 */
  unk4;
  unk8;
  unkC;
}           D_801107D8;
void       *D_801101C0;
void       *D_801101D4;
u16         D_80110918;

struct {
  s16 unk0;
  s16 unk2;
  s16 unk4;
  s16 unk6;
}           D_80112130[16]; /* last entry is D_801121B0 */

/* these do not seem to be pure memory addresses */
u8          D_801124B6;
u16         D_801124B8;
u16         D_801124C6;
u16         D_801124CE;
u8          D_80112566;
u16         D_80112568;
u16         D_80112576;
u16         D_8011257E;
u8          D_80112616;
u16         D_80112618;
u16         D_80112626;
u16         D_8011262E;
u8          D_801126C6;
u16         D_801126C8;
u16         D_801126D6;
struct {
  u16 unk0;
  u16 unk26DE;
} D_801126DC;

s32         D_80121858;
struct {
  void *unk4;
  s32 unk8;
}           D_80121930;
struct {
  u8 unk0; /* copied to D_80121B00 */
  u8 unk1; /* copied to D_80121B01 */
  u8 unk2; /* copied to D_80121B02 */
  u8 unk3; /* copied to D_80121B03 */
  u8 unk4; /* copied to D_80121B04 */
  u8 unk5; /* copied to D_80121B05 */
}           D_80121978[1]; /* unknown length */

/* copied from D_80121978[n] */
u8          D_80121B00;
u8          D_80121B01;
u8          D_80121B02;
u8          D_80121B03;
u8          D_80121B04;
u8          D_80121B05;

s16         D_801235B0;
u8          D_80123700;
u8          D_80123750;
u8          D_80123751;
u8          D_80123752;
s32         D_80123758;
s32         D_80123768;
s8          D_80123788;
u8          D_8012378A;
u8          D_8012378B;
s8          D_8012378C;
u8          D_8012378D;
u8          D_8012378E;
u8          D_8012378F;
s32         D_80123778;
u8          D_80123789;
u8          D_801237A0;
s32         D_80123790;

OSThread    gMainThread; /* 0x801237B0 */
OSThread    gThread2;    /* 0x80123960 */
OSMesgQueue D_80123CC0;
OSMesg      D_80123CD8;

struct {
  u16 unk0;
  u16 unk2;
  void *unk768;
}           D_801240A8;
struct {
  void *unk0; /* points to D_801240A8->unk768 */
  s32 unk4;
}           D_80124820;

u8          D_8012482A;
u8          D_8012482B;
u8          D_8012482C;

OSThread    gThread3;                /* 0x8015A6B8 */
void       *gThread5StackPointer;    /* 0x80158620 */
void       *gThread6StackPointer;    /* 0x8015A620 */
OSThread    gThread7;                /* 0x8015DEB0 */
void       *gMainThreadStackPointer; /* 0x80324480 */
void       *gThread2StackPointer;    /* 0x80328480 */
