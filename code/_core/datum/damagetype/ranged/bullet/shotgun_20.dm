/damagetype/ranged/bullet/shotgun_20/
	damage_type_to_fatigue = list( //What percentage of damage blocked is converted into fatigue.
		BLADE = 0.20,
		BLUNT = 0.3,
		PIERCE = 0.1,
		BOMB = 1
	)

/damagetype/ranged/bullet/shotgun_20/buckshot
	name = "group of buckshot pellets"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = 30*0.5,
		BLUNT = 30*0.25,
		PIERCE = 30*0.25
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 20*0.5,
		BLUNT = 20*0.25,
		PIERCE = 20*0.25
	)

	falloff = 3

/damagetype/ranged/bullet/shotgun_20/buckshot/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL

/damagetype/ranged/bullet/shotgun_20/slug
	name = "shotgun slug"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 45*0.8,
		PIERCE = 45*0.2
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 40*0.9,
		PIERCE = 40*0.1
	)

	falloff = VIEW_RANGE

/damagetype/ranged/bullet/shotgun_20/slug/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL

/damagetype/ranged/bullet/shotgun_20/flechette
	name = "shotgun flechette"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		PIERCE = 30*0.75
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		PIERCE = 20*3
	)

	falloff = 3

/damagetype/ranged/bullet/shotgun_20/flechette/surplus
	damage_mod = SURPLUS_MUL
	penetration_mod = SURPLUS_MUL