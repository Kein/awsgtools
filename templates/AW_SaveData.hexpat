//---------------------------------------------------------
//--- imHex v14.0 Binary Template
//
//      File: AW_SaveData.bt
//   Authors: Kein
//   Version: 0.1
//   Purpose: Parser for Animal Well save game data
//   Category: Game
//   File Mask: *.sav
//   History: 
//     0.1  - Initial port from 010
//---------------------------------------------------------

// ===================================================
// DECALRATIONS
// ===================================================
#pragma loop_limit 500000
#pragma endian little

#include <std/mem.pat>
import std.io;
import std.string;


// -------------------------------
// ENUMS
// -------------------------------
enum PixelColor : u8 {
    N=0,
    B,
    R,
    Y
};

enum ControllerStyle: u8 {
    PS5=0,
    Xbox,
    Nintendo,
    Keyboard
};

enum Graphics: u8 {
    Good=0,
    Better,
    Best
};

enum Language: u8 {
    English=0,
    Spanish,
    French,
    Italian,
    German,
    Chinese,
    Korean,
    Japanese,
    Portuguese,
    Ukrainian,
    Russian
};

enum FlameState : u8 {
    Sealed=0,
    Cracked,
    CrackedMore,
    GlassBroken,
    FlameCollected,
    FlameUsed
};

enum KangarooShardState: u8 {
    None,
    Dropped,
    PickedUp,
    Inserted
};

enum StampType : u16 {
    Chest = 0,
    Heart,
    Skull,
    Diamond,
    Spiral,
    Flame,
    Grid,
    Question
};

// -------------------------------
// HEADER
// -------------------------------
bitfield AchievementData {
    PLATINUM : 1;
    EXPLORER : 1 [[comment("Find the map")]];
    SECRET_EGG : 1 [[comment("Find a secret egg")]];
    EGG_ENJOYER : 1 [[comment("Find 8 secret eggs")]];
    EGG_HOBBYIST : 1 [[comment("Find 16 secret eggs")]];
    EGG_LORD : 1 [[comment("Find 32 secret eggs")]];
    EGG_WELL : 1 [[comment("Find all secret eggs")]];
    SECRET_RABBIT : 1 [[comment("Find a secret rabbit")]];
    CHAMELEON : 1 [[comment("Find the V. flame")]];
    GHOST : 1 [[comment("Find the P. flame")]];
    SEAHORSE : 1 [[comment("Find the B. flame")]];
    OSTRICH : 1 [[comment("Find the G. flame")]];
    CANDLE_BRIGHT : 1 [[comment("Light all candles")]];
    MANTICORE : 1 [[comment("Release the Manticore")]];
    SNEAK : 1 [[comment("Sneak up on a squirrel")]];
    GOOD_ENDING : 1 [[comment("Get crushed by a chinchilla")]];
    BACK_AND_FORTH_FOREVER : 1 [[comment("Find a new way to get around")]];
    BUBBLE_ECSTASY : 1 [[comment("Pop 1000 bubbles")]];
    TRAVEL_FLUTE : 1 [[comment("Find another way to get around")]];
    WALK_THE_DOG : 1 [[comment("Find a different way to get around")]];
    EXIT : 1 [[comment("Leave the well")]];
    pad: 11 [[hidden]];
};


// Global UNLOCKABLES
bitfield UnlockableData {
    StopWatch : 1;
    Pedometer : 1;
    PinkPhone : 1;
    SouvenirCup : 1;
    OrigamiFig : 1;
    Rabbits : 1;
    Owl : 1;
    DecorativeRabbit : 1;
    Fish : 1;
    Donkey : 1;
    Cat : 1;
    MamaCha : 1;
    Giraffe : 1;
    IncenseBurner : 1;
    Peacock : 1;
    Otter : 1;
    Duck : 1;
    Unlockable18 : 1 [[hidden]];
    Unlockable19 : 1 [[comment("set by game, we dont know why")]];
    reserved : 12 [[hidden]];
};


struct Header {
    u32              Version       [[comment("Save file version")]];
    AchievementData  Achievements;
    u32              FrameSeed     [[comment("seed value based on frame counter that starts when game is booted and ends when last flame disappears in the intro")]];
    u8               SelectedSlot  [[comment("Last selected/played save slot")]];
    u8               SaveHash      [[format_read("ReadHash"), format_write("WriteHash"), comment("This needs to be updated every time before you load the file!")]];
    u8               SaveEditNoted [[comment("only relevant at runtime")]];
    u8               Unk           [[hidden]];
    UnlockableData   Unlockables   [[comment("Both figurines and global items")]];
    u32              Reserved      [[hidden]];
};


// -------------------------------
// SLOT
// -------------------------------
struct Timestamp {
    u16 Year;
    u8 Month;
    u8 Day;
    u8 Hour;
    u8 Minutes;
    u8 Seconds;
    u8 pad [[hidden]];
};


struct CrankData { 
    u16 Crank_0604_0;
    u16 Crank_0604_1;
    u16 Crank_0805;
    u16 Crank_0506;
    u16 Crank_0307;
    u16 Crank_0509;
    u16 Crank_0709;
    u16 Crank_0711_0;
    u16 Crank_0711_1;
    u16 Crank_0713;
    u16 Crank_1013;
    u16 Crank_1213_0;
    u16 Crank_1213_1;
    u16 Crank_0415_0;
    u16 Crank_0415_1;
    u16 Crank_0415_2;
    u16 Crank_0217_0;
    u16 Crank_0217_1;
    u16 Crank_0617;
    u16 Crank_1517;
    u16 unknown_28;
    u16 unknown_2A;
    u16 Crank_0818;
    u16 unknown_2E;
};


bitfield KeyDoorData { 
    Door_00_0 : 1;
    Door_00_1 : 1;
    Door_00_2 : 1;
    Door_00_3 : 1;
    Door_00_4 : 1;
    Door_00_5 : 1;
    Door_00_6 : 1;
    Door_00_7 : 1;
    Door_01_0 : 1;
    Door_01_1 : 1;
    Door_01_2 : 1;
    Door_01_3 : 1;
    Door_01_4 : 1;
    Door_01_5 : 1;
    Door_01_6 : 1;
    Door_01_7 : 1;
    Door_02_0 : 1;
    Door_02_1 : 1;
    Door_02_2 : 1;
    Door_02_3 : 1;
    Door_02_4 : 1;
    Door_02_5 : 1;
    Door_02_6 : 1;
    Door_02_7 : 1;
    Door_03_0 : 1;
    Door_03_1 : 1;
    Door_03_2 : 1;
    Door_03_3 : 1;
    Door_03_4 : 1;
    Door_03_5 : 1;
    Door_03_6 : 1;
    Door_03_7 : 1;
    Door_04_0 : 1;
    Door_04_1 : 1;
    Door_04_2 : 1;
    Door_04_3 : 1;
    Door_04_4 : 1;
    Door_04_5 : 1;
    Door_04_6 : 1;
    Door_04_7 : 1;
    Door_05_0 : 1;
    Door_05_1 : 1;
    Door_05_2 : 1;
    Door_05_3 : 1;
    Door_05_4 : 1;
    Door_05_5 : 1;
    Door_05_6 : 1;
    Door_05_7 : 1;
    Door_06_0 : 1;
    Door_06_1 : 1;
    Door_06_2 : 1;
    Door_06_3 : 1;
    Door_06_4 : 1;
    Door_06_5 : 1;
    Door_06_6 : 1;
    Door_06_7 : 1;
    Door_07_0 : 1;
    Door_07_1 : 1;
    Door_07_2 : 1;
    Door_07_3 : 1;
    Door_07_4 : 1;
    Door_07_5 : 1;
    Door_07_6 : 1;
    Door_07_7 : 1;
    Door_08_0 : 1;
    Door_08_1 : 1;
    Door_08_2 : 1;
    Door_08_3 : 1;
    Door_08_4 : 1;
    Door_08_5 : 1;
    Door_08_6 : 1;
    Door_08_7 : 1;
    Door_09_0 : 1;
    Door_09_1 : 1;
    Door_09_2 : 1;
    Door_09_3 : 1;
    Door_09_4 : 1;
    Door_09_5 : 1;
    Door_09_6 : 1;
    Door_09_7 : 1;
    Door_0A_0 : 1;
    Door_0A_1 : 1;
    Door_0A_2 : 1;
    Door_0A_3 : 1;
    Door_0A_4 : 1;
    Door_0A_5 : 1;
    Door_0A_6 : 1;
    Door_0A_7 : 1;
    Door_0B_0 : 1;
    Door_0B_1 : 1;
    Door_0B_2 : 1;
    Door_0B_3 : 1;
    Door_0B_4 : 1;
    Door_0B_5 : 1;
    Door_0B_6 : 1;
    Door_0B_7 : 1;
    Door_0C_0 : 1;
    Door_0C_1 : 1;
    Door_0C_2 : 1;
    Door_0C_3 : 1;
    Door_0C_4 : 1;
    Door_0C_5 : 1;
    Door_0C_6 : 1;
    Door_0C_7 : 1;
    Door_0D_0 : 1;
    Door_0D_1 : 1;
    Door_0D_2 : 1;
    Door_0D_3 : 1;
    Door_0D_4 : 1;
    Door_0D_5 : 1;
    Door_0D_6 : 1;
    Door_0D_7 : 1;
    Door_0E_0 : 1;
    Door_0E_1 : 1;
    Door_0E_2 : 1;
    Door_0E_3 : 1;
    Door_0E_4 : 1;
    Door_0E_5 : 1;
    Door_0E_6 : 1;
    Door_0E_7 : 1;
    Door_0F_0 : 1;
    Door_0F_1 : 1;
    Door_0F_2 : 1;
    Door_0F_3 : 1;
    Door_0F_4 : 1;
    Door_0F_5 : 1;
    Door_0F_6 : 1;
    Door_0F_7 : 1;
} [[comment("Ordering unknown")]];


struct FillData {
    u8 Fill_0711;
    u8 Fill_0415_0 [[comment("Potentially incorrect.")]];
    u8 Fill_0415_1 [[comment("Which would make this the 0th one instead.")]];
    u8 Fill_0415_2;
    u8 Fill_0415_3;
};

bitfield ChestData {
    room_0403_0 : 1;
    room_0404_0 : 1;
    room_0407_0 : 1;
    room_0411_0 : 1;
    unknown_00_4 : 1;
    room_0414_0 : 1;
    room_0502_0 : 1;
    room_0517_0 : 1;

    unknown_01_0 : 1;
    room_0603_0 : 1;
    unknown_01_2 : 1;
    room_0608_0 : 1 [[comment("match")]];
    room_0608_1 : 1;
    room_0613_0 : 1 [[comment("match")]];
    room_0617_0 : 1;
    unknown_01_7 : 1;

    room_0703_0 : 1 [[comment("key")]];
    room_0704_0 : 1;
    unknown_02_2 : 1;
    room_0710_0 : 1 [[comment("match")]];
    room_0710_1 : 1;
    room_0711_0 : 1 [[comment("match")]];
    room_0711_1 : 1;
    room_0717_0 : 1;

    room_0802_0 : 1;
    room_0803_0 : 1;
    unknown_03_2 : 1;
    room_0808_0 : 1;
    room_0810_0 : 1;
    room_0811_0 : 1;
    unknown_03_6 : 1 [[comment("slink")]];
    room_0814_0 : 1;

    room_0814_1 : 1;
    room_0815_0 : 1;
    room_0815_1 : 1 [[comment("key")]];
    room_0902_0 : 1;
    room_0903_0 : 1;
    unknown_04_5 : 1;
    room_0910_0 : 1 [[comment("match")]];
    unknown_04_7 : 1;

    room_0912_0 : 1;
    room_0913_0 : 1;
    room_0913_1 : 1;
    room_1002_0 : 1;
    room_1003_0 : 1;
    room_1006_0 : 1;
    room_1007_0 : 1;
    room_1008_0 : 1 [[comment("Manticore Egg65 Chest")]];

    room_1008_1 : 1;
    room_1008_2 : 1;
    room_1009_0 : 1;
    room_1010_0 : 1;
    room_1010_1 : 1;
    room_1015_0 : 1;
    room_1017_0 : 1 [[comment("key")]];
    room_1104_0 : 1;

    room_1108_0 : 1 [[comment("match")]];
    room_1109_0 : 1;
    room_1205_0 : 1;
    room_1208_0 : 1;
    room_1210_0 : 1;
    room_1211_0 : 1;
    room_1213_0 : 1 [[comment("key")]];
    room_1214_0 : 1 [[comment("match")]];

    room_1214_1 : 1;
    room_1217_0 : 1;
    room_1302_0 : 1;
    room_1303_0 : 1;
    unknown_08_4 : 1 [[comment("b. wand")]];
    room_1305_0 : 1;
    room_1307_0 : 1 [[comment("match")]];
    unknown_08_7 : 1 [[comment("dream egg")]];

    room_1314_0 : 1;
    room_1317_0 : 1;
    room_1409_0 : 1;
    room_1411_0 : 1;
    room_1412_0 : 1;
    room_1415_0 : 1;
    room_1417_0 : 1;
    unknown_09_7 : 1;

    room_1506_0 : 1;
    room_1512_0 : 1 [[comment("match")]];
    room_1513_0 : 1 [[comment("key")]];
    room_1515_0 : 1 [[comment("key")]];
    unknown_0A_4 : 1;
    unknown_0A_5 : 1;
    room_1608_0 : 1;
    room_1609_0 : 1;

    room_1614_0 : 1;
    unknown_0B_1 : 1;
    unknown_0B_2 : 1;
    room_1713_0 : 1;
    room_1714_0 : 1;
    room_1715_0 : 1;
    room_1716_0 : 1;
    unknown_0B_7 : 1;

    unknown_0C_0 : 1;
    room_1814_0 : 1;
    unknown_0C_2 : 1;
    unknown_0C_3 : 1;
    room_1908_0 : 1;
    pad : 27 [[hidden]];
} [[comment("Room coordinates are yx_id not xy_id")]];


bitfield ButtonDoorsData {
    room_0403_0 : 1;
    room_0410_0 : 1;
    room_0412_0 : 1;
    room_0413_0 : 1;
    room_0414_0 : 1;
    room_0414_1 : 1;
    room_0416_0 : 1;
    room_0510_0 : 1;

    room_0512_0 : 1;
    room_0514_0 : 1;
    room_0515_0 : 1;
    unknown_01_3 : 1;
    room_0607_0 : 1;
    room_0609_0 : 1;
    room_0610_0 : 1;
    room_0611_0 : 1;

    room_0611_1 : 1;
    room_0612_0 : 1;
    room_0613_0 : 1;
    room_0614_0 : 1;
    room_0615_0 : 1;
    room_0615_1 : 1;
    room_0616_0 : 1;
    room_0703_0 : 1;

    room_0704_0 : 1;
    room_0705_0 : 1;
    room_0706_0 : 1;
    room_0713_0 : 1;
    room_0716_0 : 1;
    room_0717_0 : 1;
    room_0803_0 : 1;
    room_0808_0 : 1;

    room_0810_0 : 1;
    room_0811_0 : 1;
    room_0813_0 : 1;
    room_0813_1 : 1;
    room_0814_0 : 1;
    room_0814_1 : 1;
    room_0814_2 : 1;
    room_0817_0 : 1;

    room_0906_0 : 1;
    room_0907_0 : 1;
    room_0910_0 : 1;
    room_0913_0 : 1;
    room_0913_1 : 1;
    room_0914_0 : 1;
    room_0916_0 : 1;
    room_0917_0 : 1;

    room_1003_0 : 1;
    room_1005_0 : 1;
    room_1006_0 : 1;
    room_1013_0 : 1;
    room_1105_0 : 1;
    room_1107_0 : 1;
    room_1114_0 : 1;
    room_1115_0 : 1;

    room_1213_0 : 1;
    room_1304_0 : 1;
    room_1307_0 : 1;
    room_1313_0 : 1;
    room_1314_0 : 1;
    room_1404_0 : 1;
    room_1405_0 : 1;
    room_1410_0 : 1;

    room_1411_0 : 1;
    room_1413_0 : 1;
    room_1414_0 : 1;
    room_1415_0 : 1;
    unknown_08_4 : 1;
    room_1504_0 : 1;
    room_1504_1 : 1;
    room_1505_0 : 1;

    room_1510_0 : 1;
    room_1515_0 : 1;
    room_1516_0 : 1;
    room_1516_1 : 1;
    room_1517_0 : 1;
    unknown_09_5 : 1;
    unknown_09_6 : 1;
    unknown_09_7 : 1;

    room_1610_0 : 1;
    room_1613_0 : 1;
    room_1615_0 : 1;
    room_1615_1 : 1;
    unknown_0A_4 : 1;
    room_1709_0 : 1;
    room_1715_0 : 1;
    room_1810_0 : 1;

    room_1813_0 : 1;
    room_1816_0 : 1;
    room_1817_0 : 1;
    unknown_0B_3 : 1;
    unknown_0B_4 : 1;
    room_1916_0 : 1;
    pad : 34 [[hidden]];
};

bitfield YellowButtonData { 
    Button_0304 : 1;
    Button_1304_0 : 1;
    Button_1304_1 : 1;
    Button_1404 : 1;
    Button_1604 : 1;
    Button_1005 : 1;
    Button_1205 : 1;
    Button_1405_0 : 1;

    Button_1405_1 : 1;
    Button_1405_2 : 1;
    Button_1505_0 : 1;
    Button_1505_1 : 1;
    Unk_01_4 : 1;
    Button_0706 : 1;
    Button_0906 : 1;
    Button_1006 : 1;

    Button_1106 : 1;
    Button_1306 : 1;
    Button_1406 : 1;
    Button_1506 : 1;
    Button_1606_0 : 1;
    Button_1606_1 : 1;
    Button_1606_2 : 1;
    Button_0307_0 : 1;

    Button_0307_1 : 1;
    Button_0307_2 : 1;
    Button_0307_3 : 1;
    Button_0407 : 1;
    Button_0507 : 1;
    Button_0607 : 1;
    Button_1307 : 1;
    Button_1607 : 1;

    Button_1707_0 : 1;
    Button_1707_1 : 1;
    Button_1707_2 : 1;
    Button_0808 : 1;
    Button_1008 : 1;
    Button_1108 : 1;
    Button_1408 : 1;
    Button_1608_0 : 1;

    Button_1608_1 : 1;
    Button_1708_0 : 1;
    Button_1708_1 : 1;
    Button_1708_2 : 1;
    Button_0609_0 : 1;
    Button_0609_1 : 1;
    Button_0709_0 : 1;
    Button_0709_1 : 1;

    Button_0709_2 : 1;
    Button_1009 : 1;
    Button_1309 : 1;
    Button_1409_0 : 1;
    Button_1409_1 : 1;
    Button_1409_2 : 1;
    Button_1609 : 1;
    Button_1709 : 1;

    Button_0310_0 : 1;
    Button_0310_1 : 1;
    Button_0310_2 : 1;
    Button_0510 : 1;
    Button_0610 : 1;
    Button_0511_0 : 1;
    Button_0511_1 : 1;
    Button_0511_2 : 1;

    Button_0511_3 : 1;
    Button_1411 : 1;
    Button_1511 : 1;
    Button_1312 : 1;
    Button_0413_0 : 1;
    Button_0413_1 : 1;
    Button_0413_2 : 1;
    Button_0713_0 : 1;

    Button_0713_1 : 1;
    Button_0713_2 : 1;
    Button_1313 : 1;
    Button_1413 : 1;
    Button_0414 : 1;
    Button_1114 : 1;
    Button_1314_0 : 1;
    Button_1314_1 : 1;

    Button_1314_2 : 1;
    Button_1314_3 : 1;
    Button_1414 : 1;
    Button_1514_0 : 1;
    Button_1514_1 : 1;
    Button_1514_2 : 1;
    Button_0315_0 : 1;
    Button_0315_1 : 1;

    Button_0315_2 : 1;
    Button_0315_3 : 1;
    Button_0515 : 1;
    Button_1015_0 : 1;
    Button_1015_1 : 1;
    Button_1015_2 : 1;
    Button_1515 : 1;
    Button_1615 : 1;

    Button_1715 : 1;
    Button_0316_0 : 1;
    Button_0316_1 : 1;
    Button_0316_2 : 1;
    Button_0316_3 : 1;
    Button_0616_0 : 1;
    Button_0616_1 : 1;
    Button_0616_2 : 1;

    Button_1016 : 1;
    Button_1316_0 : 1;
    Button_1316_1 : 1;
    Button_1316_2 : 1;
    Button_1316_3 : 1;
    Button_0917 : 1;
    Button_0918_0 : 1;
    Button_0918_1 : 1;

    Button_0918_2 : 1;
    Button_0918_3 : 1;
    Button_1018 : 1;
    Button_1118_0 : 1;
    Button_1118_1 : 1;
    Button_1118_2 : 1;
    Button_1118_3 : 1;
    Button_1318_0 : 1;

    Button_1318_1 : 1;
    Button_1318_2 : 1;
    Button_1618_0 : 1;
    Button_1618_1 : 1;
    Button_1618_2 : 1;
    Button_1718_0 : 1;
    Button_1718_1 : 1;
    Button_1718_2 : 1;

    Button_1718_3 : 1;
    Unk_10_1 : 1;
    Unk_10_2 : 1;
    Unk_10_3 : 1;
    Button_1319_0 : 1;
    Button_1319_1 : 1;
    pad : 58  [[hidden]];
};


bitfield PurpleButtonData {
    Button_1204_0 : 1;
    Button_1204_1 : 1;
    Button_1204_2 : 1;
    Button_1204_3 : 1;
    Button_1206_0 : 1;
    Button_1206_1 : 1;
    Unk_00_6 : 1;
    Unk_00_7 : 1;

    Button_1308_0 : 1;
    Button_1308_1 : 1;
    Button_1310_0 : 1;
    Button_1310_1 : 1;
    Button_0514_0 : 1;
    Button_0514_1 : 1;
    Button_0514_2 : 1;
    Button_1014_0 : 1;

    Button_1014_1 : 1;
    Button_1014_2 : 1;
    Button_1516_0 : 1;
    Button_1516_1 : 1;
    Unk_02_4 : 1;
    Button_1219 : 1;
    Button_1319 : 1;
    Button_1619_0 : 1;

    Button_1619_1 : 1;
    Button_1619_2 : 1;
    Button_1619_3 : 1;
    pad : 37 [[hidden]];
};


bitfield GreenButtonData {
    Button_0210 : 1;
    Button_0211 : 1;
    Button_0511 : 1;
    Button_0213 : 1;
    Unk_00_4 : 1;
    Button_1519 : 1;
    Button_1719 : 1;
    pad : 57 [[hidden]];
} [[comment("Room coordinates are yx_id not xy_id")]];


bitfield FruitData {
    unknown_00_0 : 1;
    unknown_00_1 : 1;
    room_0404_0 : 1;
    unknown_00_3 : 1;
    room_0407_0 : 1;
    room_0407_1 : 1;
    room_0408_0 : 1;
    room_0410_0 : 1;

    room_0412_0 : 1;
    room_0412_1 : 1;
    room_0416_0 : 1;
    room_0504_0 : 1;
    room_0505_0 : 1;
    room_0510_0 : 1;
    room_0511_0 : 1;
    unknown_01_7 : 1;

    room_0513_0 : 1;
    room_0604_0 : 1;
    room_0606_0 : 1;
    room_0608_0 : 1;
    room_0609_0 : 1;
    room_0609_1 : 1;
    room_0611_0 : 1;
    room_0613_0 : 1;

    room_0617_0 : 1;
    unknown_03_1 : 1;
    unknown_03_2 : 1;
    unknown_03_3 : 1;
    room_0707_0 : 1;
    room_0712_0 : 1;
    room_0714_0 : 1;
    unknown_03_7 : 1;

    unknown_04_0 : 1;
    room_0716_0 : 1;
    room_0716_1 : 1;
    room_0802_0 : 1;
    room_0804_0 : 1;
    room_0805_0 : 1;
    room_0807_0 : 1;
    room_0810_0 : 1;

    room_0812_0 : 1;
    room_0814_0 : 1;
    room_0906_0 : 1;
    room_0910_0 : 1;
    room_0910_1 : 1;
    room_0911_0 : 1;
    room_0911_1 : 1;
    room_0912_0 : 1;

    room_0913_0 : 1;
    room_0915_0 : 1;
    room_0915_1 : 1;
    room_0916_0 : 1;
    room_0917_0 : 1;
    room_1002_0 : 1;
    room_1002_1 : 1;
    room_1003_0 : 1;

    room_1004_0 : 1;
    room_1004_1 : 1;
    room_1005_0 : 1;
    room_1007_0 : 1;
    room_1015_0 : 1;
    room_1016_0 : 1;
    room_1017_0 : 1;
    room_1102_0 : 1;

    room_1103_0 : 1;
    room_1103_1 : 1;
    room_1110_0 : 1;
    room_1110_1 : 1;
    room_1114_0 : 1;
    room_1202_0 : 1;
    room_1203_0 : 1;
    room_1204_0 : 1;

    room_1204_1 : 1;
    unknown_09_1 : 1;
    room_1206_0 : 1;
    room_1208_0 : 1;
    room_1210_0 : 1;
    unknown_09_5 : 1;
    unknown_09_6 : 1;
    unknown_09_7 : 1;

    room_1216_0 : 1;
    room_1303_0 : 1;
    room_1305_0 : 1;
    room_1305_1 : 1;
    room_1313_0 : 1;
    room_1314_0 : 1;
    room_1314_1 : 1;
    room_1404_0 : 1;

    unknown_0B_0 : 1;
    room_1411_0 : 1;
    room_1412_0 : 1;
    room_1413_0 : 1;
    unknown_0B_4 : 1;
    room_1416_0 : 1;
    room_1514_0 : 1;
    room_1514_1 : 1;

    room_1515_0 : 1;
    room_1516_0 : 1;
    room_1517_0 : 1;
    room_1603_0 : 1;
    unknown_0C_4 : 1;
    room_1607_0 : 1;
    unknown_0C_6 : 1;
    room_1709_0 : 1;

    room_1710_0 : 1;
    unknown_0D_1 : 1;
    unknown_0D_2 : 1;
    unknown_0D_3 : 1;
    unknown_0D_4 : 1;
    unknown_0D_5 : 1;
    room_1816_0 : 1;
    room_1907_0 : 1;

    room_1916_0 : 1;
    unknown_0E_1 : 1;
    room_1917_0 : 1;
    pad : 13 [[hidden]];
} [[comment("Room coordinates are yx_id not xy_id")]];


bitfield FirecrackerData {
    Firecracker_0504 : 1;
    Firecracker_0704 : 1;
    Firecracker_0804 : 1;
    Firecracker_1704 : 1;
    Firecracker_0905 : 1;
    Firecracker_1105 : 1;
    Firecracker_0306_0 : 1;
    Firecracker_0306_1 : 1;

    Firecracker_0306_2 : 1;
    Firecracker_0207 : 1;
    Firecracker_1106_0 : 1;
    Firecracker_1106_1 : 1;
    Unk_01_4 : 1;
    Firecracker_0707 : 1;
    Firecracker_1007 : 1;
    Unk_01_7 : 1;

    Firecracker_1607 : 1;
    Firecracker_0508_0 : 1;
    Firecracker_0508_1 : 1;
    Firecracker_0508_2 : 1;
    Firecracker_0409 : 1;
    Firecracker_0509_0 : 1;
    Firecracker_0509_1 : 1;
    Firecracker_0509_2 : 1;

    Firecracker_0509_3 : 1;
    Firecracker_0609_0 : 1;
    Firecracker_0609_1 : 1;
    Firecracker_1109 : 1;
    Firecracker_1509 : 1;
    Firecracker_1410 : 1;
    Firecracker_1510 : 1;
    Firecracker_1211_0 : 1;

    Firecracker_1211_1 : 1;
    Firecracker_1012_0 : 1;
    Firecracker_1012_1 : 1;
    Firecracker_1412 : 1;
    Firecracker_0513 : 1;
    Firecracker_0613_0 : 1;
    Firecracker_0613_1 : 1;
    Firecracker_0613_2 : 1;

    Firecracker_0613_3 : 1;
    Firecracker_1113 : 1;
    Firecracker_1413 : 1;
    Firecracker_0614_0 : 1;
    Firecracker_0614_1 : 1;
    Firecracker_0614_2 : 1;
    Firecracker_0614_3 : 1;
    Firecracker_0714_0 : 1;

    Firecracker_0714_1 : 1;
    Firecracker_0714_2 : 1;
    Firecracker_1114 : 1;
    Firecracker_1514 : 1;
    Firecracker_1115 : 1;
    Firecracker_1215 : 1;
    Firecracker_1315 : 1;
    Unk_06_7 : 1;

    Unk_07_0 : 1;
    Firecracker_0917 : 1;
    Firecracker_1017 : 1;
    Unk_07_3 : 1;
    Firecracker_0818 : 1;
    Firecracker_0918 : 1;
    Firecracker_1018_0 : 1;
    Firecracker_1018_1 : 1;
};


bitfield EggData {
    ReferenceEgg : 1 [[comment("room_0403_0")]];
    BrownEgg : 1 [[comment("room_0404_0")]];
    RawEgg : 1 [[comment("room_0407_0")]];
    PickledEgg : 1 [[comment("unknown_00_3")]];
    BigEgg : 1 [[comment("room_0411_0")]];
    SwanEgg : 1 [[comment("room_0414_0")]];
    ForbiddenEgg : 1 [[comment("room_0502_0")]];
    ShadowEgg : 1 [[comment("room_0517_0")]];

    VanityEgg : 1 [[comment("unknown_01_0")]];
    EggAsService : 1 [[comment("room_0603_0")]];
    DepravedEgg : 1 [[comment("room_0608_0")]];
    ChaosEgg : 1 [[comment("room_0617_0")]];
    UpsideDownEgg : 1 [[comment("unknown_01_4")]];
    EvilEgg : 1 [[comment("unknown_01_5")]];
    SweetEgg : 1 [[comment("room_0710_0")]];
    ChocolateEgg : 1 [[comment("room_0711_0")]];

    ValueEgg : 1 [[comment("room_0717_0")]];
    PlantEgg : 1 [[comment("room_0802_0")]];
    RedEgg : 1 [[comment("room_0803_0")]];
    OrangeEgg : 1 [[comment("unknown_02_3")]];
    SourEgg : 1 [[comment("room_0810_0")]];
    PostModernEgg : 1 [[comment("room_0811_0")]];
    UniversalBasicEgg : 1 [[comment("room_0814_0")]];
    LaissezFaireEgg : 1 [[comment("room_0814_1")]];

    ZenEgg : 1 [[comment("room_0815_0")]];
    FutureEgg : 1 [[comment("unknown_03_1")]];
    FriendshipEgg : 1 [[comment("room_0903_0")]];
    TruthEgg : 1 [[comment("room_unk")]];
    TranscendentalEgg : 1 [[comment("room_0913_0")]];
    AncientEgg : 1 [[comment("room_1002_0")]];
    MagicEgg : 1 [[comment("room_1003_0")]];
    MysticEgg : 1 [[comment("room_1006_0")]];

    HolidayEgg : 1 [[comment("room_1010_0")]];
    RainEgg : 1 [[comment("room_1010_1")]];
    RazzleEgg : 1 [[comment("room_1015_0")]];
    DazzleEgg : 1 [[comment("room_1104_0")]];
    VirtualEgg : 1 [[comment("room_1109_0")]];
    NormalEgg : 1 [[comment("room_1205_0")]];
    GreatEgg : 1 [[comment("room_1208_0")]];
    GorgeousEgg : 1 [[comment("room_1210_0")]];

    PlanetEgg : 1 [[comment("unknown_05_0")]];
    MoonEgg : 1 [[comment("room_1217_0")]];
    GalaxyEgg : 1 [[comment("room_1302_0")]];
    SunsetEgg : 1 [[comment("room_1303_0")]];
    GoodnightEgg : 1 [[comment("room_1305_0")]];
    DreamEgg : 1 [[comment("room_1313_0")]];
    TravelEgg : 1 [[comment("room_1314_0")]];
    PromiseEgg : 1 [[comment("room_1317_0")]];

    IceEgg : 1 [[comment("room_1409_0")]];
    FireEgg : 1 [[comment("room_1412_0")]];
    BubbleEgg : 1 [[comment("room_1415_0")]];
    DesertEgg : 1 [[comment("room_1417_0")]];
    CloverEgg : 1 [[comment("room_1506_0")]];
    BrickEgg : 1 [[comment("unknown_06_5")]];
    NeonEgg : 1 [[comment("unknown_06_6")]];
    IridescentEgg : 1 [[comment("room_1609_0")]];

    RustEgg : 1 [[comment("room_1614_0")]];
    ScarletEgg : 1 [[comment("unknown_07_1")]];
    SapphireEgg : 1 [[comment("room_1713_0")]];
    RubyEgg : 1 [[comment("room_1714_0")]];
    JadeEgg : 1 [[comment("room_1715_0")]];
    ObsidianEgg : 1 [[comment("room_1716_0")]];
    CrystalEgg : 1 [[comment("unknown_07_6")]];
    GoldenEgg : 1 [[comment("unknown_07_7")]];
} [[comment("Room coordinates are yx_id not xy_id")]];;


bitfield ExplosionData {
    Explosion_1105 : 1;
    Explosion_1706 : 1;
    Explosion_1007 : 1;
    Explosion_1108 : 1;
    Unk_00_4 : 1;
    Explosion_1611 : 1;
    Explosion_1711_0 : 1;
    Explosion_1711_1 : 1;

    Explosion_1414 : 1;
    Explosion_1615 : 1;
    pad : 22 [[hidden]];
};


bitfield DetonatorData {
    Detonator_1105 : 1;
    Detonator_1706 : 1;
    Detonator_1007 : 1;
    Detonator_1611 : 1;
    Detonator_1711_0 : 1;
    Detonator_1711_1 : 1;
    Detonator_1414 : 1;
    Detonator_1615 : 1;

    Detonator_0719 : 1;
    pad : 23 [[hidden]];
};


bitfield BunnyData {
    TutorialBunny : 1        [[comment("statue 4")]];
    IllegallBunny1 : 1;
    OrigamiBunny : 1         [[comment("statue 17")]];
    CrowBunny : 1            [[comment("statue 10")]];
    GhostBunny : 1           [[comment("statue 9")]];
    IllegallBunny2 : 1;
    FishBunny : 1       [[comment("statue 8")]];
    MapColumnsBunny : 1      [[comment("statue 5")]];
    TVBunny : 1              [[comment("statue 16")]];
    UVBunny : 1              [[comment("statue 7")]];
    BulbBunny : 1            [[comment("statue 13")]];
    ChinchillaBunny : 1      [[comment("statue 2")]];
    IllegallBunny3 : 1;
    IllegallBunny4 : 1;
    IllegallBunny5 : 1;
    MuralBunny : 1      [[comment("statue 1")]];
    IllegallBunny6 : 1;
    IllegallBunny7 : 1;
    IllegallBunny8 : 1;
    IllegallBunny9 : 1;
    IllegallBunny10 : 1;
    IllegallBunny11 : 1;
    DuckBunny : 1            [[comment("statue 11")]];
    IllegallBunny12 : 1;
    IllegallBunny13 : 1;
    GhostDog : 1        [[comment("statue 18")]];
    IllegallBunny14 : 1;
    IllegallBunny15 : 1;
    DreamBunny : 1           [[comment("statue 12")]];
    IllegallBunny16 : 1;
    FloorIsLavaBunny : 1     [[comment("statue 14")]];
    SpikeRoomBunny : 1       [[comment("statue 20")]];
};


bitfield SquirrelData {
    Squirrel_0905 : 1;
    Squirrel_0909 : 1;
    Squirrel_1510 : 1;
    Squirrel_0911 : 1;
    Squirrel_1012 : 1;
    Squirrel_0813 : 1;
    Squirrel_0314 : 1;
    Squirrel_1414 : 1;

    Squirrel_0715 : 1;
    Squirrel_1516 : 1;
    Squirrel_0718 : 1;
    Squirrel_0818 : 1;
    Squirrel_0919 : 1;

    pad : 3 [[hidden]];
};

bitfield CatData { 
    CatCage_1618_0 : 1;
    CatCage_1618_1 : 1;
    CatCage_1618_2 : 1;
    CatCage_1419_0 : 1;
    CatCage_1419_1 : 1;
    WheelCage : 1;

    pad : 10 [[hidden]];
};


struct HPData {
    u8 TotalHearts [[comment("This includes ALL hearts")]];
    u8 MaxYellow;
    u16 GroundHogYear;
};


bitfield Equipment {
    Unknown : 1;
    Firecrackers : 1;
    Flute : 1;
    Lantern : 1;
    Top : 1;
    Disc : 1;
    BWand : 1;
    Yoyo : 1;

    Slink : 1;
    Remote : 1;
    Ball : 1;
    Wheel : 1;
    UVLight : 1;

    pad : 3 [[hidden]];
};


bitfield CandlesData {
    Candle_0406 : 1;
    Candle_0806 : 1;
    Candle_0407 : 1;
    Candle_0607 : 1;
    Candle_0609 : 1;
    Candle_1509 : 1;
    Candle_0513 : 1;
    Candle_1013 : 1;

    Candle_1613 : 1;

    pad : 7 [[hidden]];
};


bitfield GhostData {
    Ghost_0806_0 : 1;
    Ghost_0407_0 : 1;
    Ghost_0607_0 : 1;
    Unk_00_3 : 1;
    Unk_00_4 : 1;
    Unk_00_5 : 1;
    Unk_00_6 : 1;
    Ghost_0513_0 : 1;

    Ghost_1013_0 : 1;
    Ghost_1613_0 : 1;
    Ghost_0714_0 : 1;

     pad : 5 [[hidden]];
};


bitfield Uncategorized1 {
    Unk_00_0 : 1;
    Uncategorized_1811 : 1 [[comment("Large, button-powered door in room (18, 11).")]];

    pad : 14 [[hidden]];
};


bitfield OtherItems {
    MockDisc : 1;
    SMedal : 1;
    Cake : 1 [[comment("from alpha, unused")]]; 
    HouseKey : 1;
    OfficeKey : 1;
    CageKey : 1 [[comment("unused")]]; 
    EMedal : 1;
    FPack : 1;
};


bitfield QuestState { 
    HouseOpened : 1 [[comment("used the house key to open the house")]];
    unknown_00_1 : 1; 
    ClosetOpened : 1  [[comment("opened the closet to get the fanny pack")]];
    unknown_00_3 : 1; 
    unknown_00_4 : 1; 
    unknown_00_5 : 1; 
    unknown_00_6 : 1; 
    unknown_00_7 : 1; 

    SwitchState : 1 [[comment("0 = right; 1 = left.")]];
    MapCollected : 1;
    StampsCollected : 1;
    PencilCollected : 1;
    ChameleonDefeated : 1;
    CheaterRingCollected : 1;
    EatenByChameleon : 1;
    InsertedSMedal : 1;

    Unk_02_0 : 1;
    Unk_02_1 : 1;
    WokeUp : 1 [[comment("Whether the flower at the start of the game was exited.")]];
    BBWandUpgrade : 1;
    ManticoreEgg65 : 1;
    EMedalInserted : 1;
    Unk_02_6 : 1;
    Unk_02_7 : 1;

    BatDefeated : 1;
    OstrichFreed : 1;
    OstrichDefeated : 1;
    EelFightActive : 1;
    EelDefeated : 1;
    NoDiscInShrine : 1 [[comment("Whether there is no disc in the dog shrine.")]];
    NoDiscInStatue : 1 [[comment("Whether there is no disc in the ghost dog head.")]];
    Unk_03_7 : 1;
};


struct LKangarooState {
    float Unk_00;
    float Unk_04;

    u8 EncounterRoomX;
    u8 EncounterRoomY;
    KangarooShardState ShardState; // u8
    u8 Unk_0B;
};


struct GKangarooState {
    u8 unkState;
    u8 Status [[comment("byte for the kangaroo's state, i think. 0 = idle, 1 = running away, 2 = attacking")]];
};


bitfield ElevatorsData {
    BlueRat : 1 [[comment("0 down, 1 up")]];
    RedRat : 1  [[comment(" 0 right, 1 left")]];
    Ostrich : 1 [[comment(" 0 right, 1 left")]];
    Dog : 1     [[comment("0 down, 1 up")]];

    pad : 4 [[hidden]];
};


bitfield TPSeenData {
    Unk_00_0 : 1 [[comment("Potentially reserved for Eel, but unused?")]];
    Chameleon : 1;
    Fish : 1;
    Bear : 1;
    Dog : 1;
    Bird : 1;
    Cat : 1;
    Hippo : 1;
};


bitfield TPActiveData {
    unk  : 1 [[hidden]];
    Frog : 1;
    Fish : 1;
    Bear : 1;
    Dog : 1;
    Bird : 1;
    Squirrel : 1;
    Hippo : 1;
};


struct FlameData {
    FlameState BFlame; 
    FlameState PFlame; 
    FlameState VFlame; 
    FlameState GFlame; 
};


bitfield EggRoomDoors {
    Door1 : 1;
    Door2 : 1;
    Door3 : 1;
    Door4 : 1;
    Unk1 : 1;
    Unk2 : 1;
    Unk3 : 1;
    Unk4 : 1;
};

struct SavedPos {
    u32 X;
    u32 Y;
};


struct MinimapRow {
    u8 FullMapRow[100] [[comment("Whole world row, starting from right, each room is 5 bytes, each bit is one tile/pixel, total 40 horizontal tiles/pixesl per room")]];
};


struct MinimapRowsData {
    MinimapRow GridRoomRow[22] [[comment("22 full world rows, denoting height of a room")]];
};


 struct StampEntry {
    u16 X;
    u16 Y;
    StampType Stamp;
};


struct StampData {
    u8 TotalStamps;
    StampType LastSelected;
    StampEntry PlacedStamps[64];
};


struct MapData {
    // ---
    StampData        PlacedStamps; // 387 bytes
    float            SimFloats[16] [[comment("Unrelated to map data")]];
    ElevatorsData    ElevatorStates;
    u8               pad3[3]       [[hidden]];
    // ---
    MinimapRowsData  RevealedMapData[24];
    u8   Pad1      [[hidden]];
    MinimapRowsData  PencilMapData[24];
    u8   Pad2      [[hidden]];
    MinimapRowsData  TileStateData[24] [[comment("Deleted/erased static tiles")]];
    u8   Pad3      [[hidden]];
};


bitfield MuralPixelRow {
    PixelColor Pixel1 : 2;
    PixelColor Pixel2 : 2;
    PixelColor Pixel3 : 2;
    PixelColor Pixel4 : 2;
    PixelColor Pixel5 : 2;
    PixelColor Pixel6 : 2;
    PixelColor Pixel7 : 2;
    PixelColor Pixel8 : 2;
    PixelColor Pixel9 : 2;
    PixelColor Pixel10 : 2;
    PixelColor Pixel11 : 2;
    PixelColor Pixel12 : 2;
    PixelColor Pixel13 : 2;
    PixelColor Pixel14 : 2;
    PixelColor Pixel15 : 2;
    PixelColor Pixel16 : 2;
    PixelColor Pixel17 : 2;
    PixelColor Pixel18 : 2;
    PixelColor Pixel19 : 2;
    PixelColor Pixel20 : 2;
    PixelColor Pixel21 : 2;
    PixelColor Pixel22 : 2;
    PixelColor Pixel23 : 2;
    PixelColor Pixel24 : 2;
    PixelColor Pixel25 : 2;
    PixelColor Pixel26 : 2;
    PixelColor Pixel27 : 2;
    PixelColor Pixel28 : 2;
    PixelColor Pixel29 : 2;
    PixelColor Pixel30 : 2;
    PixelColor Pixel31 : 2;
    PixelColor Pixel32 : 2;
    PixelColor Pixel33 : 2;
    PixelColor Pixel34 : 2;
    PixelColor Pixel35 : 2;
    PixelColor Pixel36 : 2;
    PixelColor Pixel37 : 2;
    PixelColor Pixel38 : 2;
    PixelColor Pixel39 : 2;
    PixelColor Pixel40 : 2;
};


bitfield LUnlockable {
    Unlockable1 : 1;
    Unlockable2 : 1;
    Unlockable3 : 1;
    Unlockable4 : 1;
    Unlockable5 : 1;
    Unlockable6 : 1;
    Unlockable7 : 1;
    Unlockable8 : 1;
    Unlockable9 : 1;
    Unlockable10 : 1;
    Unlockable11 : 1;
    Unlockable12 : 1;
    Unlockable13 : 1;
    Unlockable14 : 1;
    Unlockable15 : 1;
    Unlockable16 : 1;
};

struct ButtonsSection {
    YellowButtonData  YellowButtons;
    u64               Unk64 [[hidden]];
    PurpleButtonData  PurpleButtons;
    GreenButtonData   GreenButtons;
};


struct PickableSection {
    FruitData        PickedUpFuits;
    FirecrackerData  PickedUpFCrackers;
};


struct Slot {
    Timestamp       SlotTime   [[color("FFD2EE")]];
    //----
    CrankData       CrankLevelsPerRoom;
    u8              Reserved[80]  [[hidden]];
    u64             ExtraKeyDoors [[comment("This is door state data too, but unknown/unmapped")]];
    KeyDoorData     KeyDoors      [[comment("Ordering is unknown")]];
    u8              Pad2[104]     [[hidden]];
    u32             Steps         [[color("FFD2EE")]];
    FillData        FillLevels;
    // --
    u8              Pad3[15]      [[hidden]];
    ChestData       OpenedChests;
    ButtonDoorsData ButtonDoors;
    // --
    ButtonsSection Buttons;
    // --
    PickableSection Pickables;
    // --
    EggData          Eggs;
    ExplosionData    Explosions;
    DetonatorData    Detonators;
    BunnyData        Bunnies;
    SquirrelData     SquirrelsQuest;
    CatData          CatQuest;
    //------------
    u16           Unk16_1          [[hidden]];
    u16           TotalFCkersPickedUp;
    u16           TotalBubblesPopped;
    u16           Unk16_2          [[hidden]];
    u16           TimesSaved;
    u16           Unk16_3          [[hidden]];
    u16           Unk16_4          [[hidden]];
    u16           Unk16_5          [[hidden]];
    u8            Unk8_1           [[hidden]];
    u8            KeysCount      [[color("D2FFD6")]];
    u8            MatchesCount   [[color("D2FFD6")]];
    u8            FCrackersCount [[color("D2FFD6")]];
    HPData        Hearts         [[color("FFD2EE")]];
    u8            Unk8_2           [[hidden]];
    EggRoomDoors  EggRoomState   [[comment("it is unclear what other flags are")]];
    u16           Unk16_6          [[hidden]];
    u32           FramesIngame   [[color("FFD2EE")]];
    u32           FramesTotal    [[color("FFD2EE")]];
    u8            Pad4[16]       [[hidden]];
    SavedPos      SavedRoomPos   [[color("CACAFF")]];
    Equipment     OwnedEquipment [[color("D2FFD6")]];
    OtherItems    Items          [[color("D2FFD6")]];
    u8            Unk8_3           [[hidden]];
    CandlesData   CandlesLit;
    u16           HitsTaken      [[color("FFD2EE"), comment("This updates along with death counter, but the relation is not known")]];
    u16           Deaths         [[color("FFD2EE")]];
    GhostData     FreightenedGhosts;
    Uncategorized1 UnkData2;
    u8            SelectedItem   [[color("D2FFD6")]];
    u8            Unk8_4           [[hidden]];
    QuestState    QuestsAndUpgrades;
    u8            GlobalProgress [[comment("some kinda progress? changed to 2 on the credits")]];
    u8            pad_3[3]       [[hidden]];
    LKangarooState Kangaroo[3];
    u8            Unk_6[6]       [[hidden]];
    FlameData     Flames;
    u8            Unk8_5           [[hidden]];
    // ---
    TPSeenData    TeleportsSeen;
    TPActiveData  TeleportsActivated;
    MapData       Map;
    MuralPixelRow Mural[20];
    // ---
    u8            Pad            [[hidden]];
    u8            Unk_128[128]   [[hidden]];
    LUnlockable   LocalUnlocks   [[comment("mimics some data from unlockables?")]];
    u16           BerriesEatenWhenFull [[comment("resets when hit or eat blue berry")]];
    u8            Pad_20[20]     [[hidden]];
} [[format_read("SlotSummary")]];



// =====================
// OPTIONS
// =====================
bitfield Toggles {
    Scanlines : 1;
    Fullscreen : 1;
    ShowTime : 1;
    ShowSteps : 1;
    Vibration : 1;
    ForcedSaveMode : 1;
    Flashing : 1;
    OverrideStyle : 1;

    SwapCancel : 1;
    IgnoreBGInput : 1;
    pad : 6      [[hidden]];
};


struct Options {
    Toggles ToggleSettings;
    Language Lang;
    u8 Unk[5]       [[hidden]];
    float SFX;
    float Music;
    ControllerStyle GamepadStyle;
    Graphics GFX;
    u8 Reserved[38] [[hidden]];
};


// =====================
// HELPER FUNCTIONS
// =====================

fn SlotSummary(auto slot) {
    if (slot.FramesTotal <= 0)
        return "<empty>";
    u8 hrs = u8((slot.FramesTotal * 16.66) / 1000 / 60 / 60);
    // hardcoded offsets LOL ImHex
    u32 numBunnies = numSetBits32(std::mem::read_unsigned(addressof(slot.Bunnies)+24, 4));
    u64 numEggs = numSetBits64(std::mem::read_unsigned(addressof(slot.Eggs)+24, 8));
    return std::format("{:d}:{:d}:{:d} {:d}.{:d}.{:d} :: ({:d}) - [{:d} hrs] - ({:d}/64) - ({:d})", slot.SlotTime.Hour, slot.SlotTime.Minutes, slot.SlotTime.Seconds,  slot.SlotTime.Day, slot.SlotTime.Month, slot.SlotTime.Year, slot.Steps, hrs, numEggs, numBunnies);
};

fn numSetBits32(u32 i) {
     i = i - ((i >> 1) & 0x55555555);
     i = (i & 0x33333333) + ((i >> 2) & 0x33333333);
     return u8((((i + (i >> 4)) & 0x0F0F0F0F) * 0x01010101) >> 24);
};

fn numSetBits64(u64 i) {
    i = i - ((i >> 1) & 0x5555555555555555);
    i = (i & 0x3333333333333333) + ((i >> 2) & 0x3333333333333333);
    return u8((((i + (i >> 4)) & 0xF0F0F0F0F0F0F0F) * 0x101010101010101) >> 56);
};

// Hash handling
fn CalculateHash()
{
    u8 total = 0;
    $ = 0;
    while ($ <= 12) {
        total = total ^ std::mem::read_unsigned($, 1);
        $ = $ + 1;
    }
    $ = 14;
    while (!std::mem::eof()) {
        total = total ^ std::mem::read_unsigned($, 1);
        $ = $ + 1;
    }
    std::print("Save hash: {:d}", total);
    return total;
};

fn WriteHash(str v) { return CalculateHash(); };
fn ReadHash(u8 hash) { return hash; };



// ===================================================
// PATTERN PARSING
// ===================================================
struct File {
    Header GlobalState;
    Slot Slots[3];
    Options Config [[color("FFD2EE")]];
} [[inline]];

File file @ 0x00;


/*
std::mem::Section Mural = std::mem::create_section("Mural");

struct Data {
  u32 RGBAData[800];
} [[hex::visualize("bitmap", RGBAData, 40, 20)]];

Data data  @ 0x00 in Mural;
data.RGBAData[0] = 1;
u8 mural[200] @ 0x26EC7;

std::print("Size: {:d}", sizeof(data.RGBAData));
std::print("FullP: {:08b}", u8(mural[0]));
std::print("Pixel1 {:08b}", u8(mural[0] & 0b00000011));  
std::print("Pixel2 {:08b}", u8((mural[0] & 0b00001100) >> 2));
std::print("Pixel3 {:08b}", u8((mural[0] & 0b00110000) >> 4));
std::print("Pixel4 {:08b}", u8((mural[0] & 0b11000000) >> 6));


fn twobit_to_rgba(ref auto _rawData, ref auto rgbaBuf) {

    for (u32 i = 0, i < 200, i = i + 1) {
        u32 rgbaIdx = (i * 4);
        rgbaBuf[rgbaIdx] = to_rgba_pixel(u8(_rawData[i] & 0b00000011));
        rgbaBuf[rgbaIdx+1] = to_rgba_pixel(u8((_rawData[i] & 0b00001100) >> 2));
        rgbaBuf[rgbaIdx+2] = to_rgba_pixel(u8((_rawData[i] & 0b00110000) >> 4));
        rgbaBuf[rgbaIdx+3] = to_rgba_pixel(u8((_rawData[i] & 0b11000000) >> 6));
    }
};

// returns u32 RGBA
fn to_rgba_pixel(u8 bbPixel) {
    match(bbPixel) {
        (1): { return 0xFFffc864; }
        (2): { return 0xFF6363fa; }
        (3): { return 0xFFC7E6FE; }
    }
    return 0xFF2f1409;
};

twobit_to_rgba(mural, data.RGBAData);






import std.sys;
import std.io;
import std.core;

import type.magic;
import type.size;

struct FDT {
    u64 Test;
};

//std::mem::MagicSearch<"\x41\x57\x41\x56\x56\x57\x53\x48\x83\xEC\x60\x48\x8B\x1D", FDT> fdt @ std::mem::base_address();
u64 test = std::mem::find_sequence(0,0x41,0x57,0x41,0x56,0x56,0x57,0x53,0x48,0x83,0xEC,0x60,0x48,0x8B,0x1D);
std::print("Size: {:ld}", test);
*/