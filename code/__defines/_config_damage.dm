#define HEALING_F 0
#define HEALING_E 1
#define HEALING_D 2
#define HEALING_C 5
#define HEALING_B 10
#define HEALING_A 15
#define HEALING_S 20
#define HEALING_X 50

#define DAMAGE_F 0
#define DAMAGE_E (3*1 + 1)
#define DAMAGE_D (3*2 + 2)
#define DAMAGE_C (3*3 + 3)
#define DAMAGE_B (3*4 + 4)
#define DAMAGE_A (3*5 + 5)
#define DAMAGE_S (3*6 + 6)
#define DAMAGE_X (3*7 + 7)

#define ARMOR_F 0
#define ARMOR_E 5
#define ARMOR_D 10
#define ARMOR_C 25
#define ARMOR_B 50
#define ARMOR_A 75
#define ARMOR_S 90
#define ARMOR_X 100

#define CLASS_F 0
#define CLASS_E 0.1
#define CLASS_D 0.2
#define CLASS_C 0.3
#define CLASS_B 0.4
#define CLASS_A 0.5
#define CLASS_S 0.75
#define CLASS_X 1

#define SKILL_F 0
#define SKILL_E 0.1
#define SKILL_D 0.2
#define SKILL_C 0.3
#define SKILL_B 0.4
#define SKILL_A 0.5
#define SKILL_S 0.75
#define SKILL_X 1


#define HUMAN_ARMOR list(HOLY=50,ARCANE=50,DARK=25,ION=INFINITY)
#define REPTILE_ARMOR list(BLADE=10,BLUNT=10,PIERCE=10,LASER=-30,ARCANE=25,HEAT=25,COLD=-25,BIO=10,HOLY=50,DARK=50,ION=INFINITY)
#define CYBORG_ARMOR list(BLADE=20,BLUNT=20,PIERCE=20,ARCANE=-100,BIO=INFINITY,RAD=INFINITY,COLD=50,HEAT=-50,HOLY=INFINITY,DARK=INFINITY)
#define DIONA_ARMOR list(BIO=-100,HOLY=50,ARCANE=75,DARK=-25,HEAT=25,COLD=25,RAD=INFINITY,ION=INFINITY)
#define SKELETON_ARMOR list(BLUNT=-50,BLADE=25,PIERCE=25,BIO=100,HOLY=-50,DARK=75,ARCANE=75,HEAT=50,COLD=50,RAD=INFINITY,ION=INFINITY)
#define MEATMEN_ARMOR list(BLUNT=25,BLADE=-25,PIERCE=25,BIO=-25,HOLY=-50,DARK=75,ARCANE=25,COLD=25,HEAT=-50,RAD=50,ION=INFINITY)


#define DEFAULT_BLOCK list(BLADE=25,BLUNT=25,PIERCE=25)
#define DEFAULT_BLOCK_MELEE list(BLADE=50,BLUNT=25,PIERCE=25)



//Melee Balance
#define DAMAGE_DAGGER 20
#define SPEED_DAGGER 8
#define AP_DAGGER 40

#define DAMAGE_SWORD 40
#define SPEED_SWORD 10
#define AP_SWORD 50

#define DAMAGE_AXE 60
#define SPEED_AXE 12
#define AP_AXE 60

#define DAMAGE_CLUB 80
#define SPEED_CLUB 14
#define AP_CLUB 70

#define DAMAGE_GREATSWORD 100
#define SPEED_GREATSWORD 16
#define AP_GREATSWORD 80

#define DAMAGE_GREATAXE 120
#define SPEED_GREATAXE 18
#define AP_GREATAXE 90

#define DAMAGE_GREATCLUB 140
#define SPEED_GREATCLUB 20
#define AP_GREATCLUB 100


//Slowdown values are automaticlly calculated. Thank god.
#define ARMOR_VERY_LIGHT 50
#define ARMOR_LIGHT 100
#define ARMOR_MEDIUM 200
#define ARMOR_HEAVY 300
#define ARMOR_VERY_HEAVY 500



#define SOUL_SIZE_COMMON 500
#define SOUL_SIZE_UNCOMMON 1000
#define SOUL_SIZE_RARE 2500
#define SOUL_SIZE_MYSTIC 5000