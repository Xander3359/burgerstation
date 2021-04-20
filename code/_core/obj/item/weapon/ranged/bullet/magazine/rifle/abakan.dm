/obj/item/weapon/ranged/bullet/magazine/rifle/abakan
	name = "\improper 5.45x39mm AN-94"
	desc = "A nuu cheeki breeki i v damkee!"
	desc_extended = "Weapon of the elite troops of the Russian army. It was developed as a replacement for the outdated AK-74. In the 'Abakan' not only the internal mechanisms are mobile, but the entire receiver along with the barrel, which allows you to reduce the recoil, therefore significantly increasing the accuracy."
	icon = 'icons/obj/item/weapons/ranged/rifle/rifle_545.dmi'
	icon_state = "inventory"
	value = 175

	shoot_delay = 2
	max_bursts = 2

	shoot_sounds = list('sound/weapons/russia/abakan.ogg') //I'm lazy

	can_wield = TRUE

	automatic = TRUE

	size = SIZE_4
	weight = 12

	heat_max = 0.2

	bullet_length_min = 38
	bullet_length_best = 39
	bullet_length_max = 40

	bullet_diameter_min = 5.4
	bullet_diameter_best = 5.45
	bullet_diameter_max = 5.46  //Just so people wouldn't load this gun with 5.56, would be really-really weird to do so - Stalkeros

	ai_heat_sensitivity = 1.5

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = TRUE, /obj/item/attachment/barrel/charger/advanced = TRUE,
		/obj/item/attachment/barrel/compensator = TRUE,
		/obj/item/attachment/barrel/extended = TRUE,
		/obj/item/attachment/barrel/suppressor = TRUE,
		/obj/item/attachment/sight/laser_sight = TRUE,
		/obj/item/attachment/sight/quickfire_adapter = TRUE,
		/obj/item/attachment/sight/red_dot = TRUE,
		/obj/item/attachment/sight/scope = TRUE,
		/obj/item/attachment/undermount/bipod = TRUE,
		/obj/item/attachment/undermount/burst_adapter = TRUE
	)

	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 20 - 16

	attachment_sight_offset_x = 13 - 16
	attachment_sight_offset_y = 21 - 16

	attachment_undermount_offset_x = 23 - 16
	attachment_undermount_offset_y = 18 - 16

	firing_pin = /obj/item/firing_pin/electronic/iff/revolutionary

	inaccuracy_modifier = 0.25
	movement_inaccuracy_modifier = 1
	movement_spread_base = 0.03

/obj/item/weapon/ranged/bullet/magazine/rifle/abakan/get_static_spread()
	if(!wielded)
		return 0.08
	return 0.003

/obj/item/weapon/ranged/bullet/magazine/rifle/abakan/get_skill_spread(var/mob/living/L)
	if(!heat_current)
		return 0
	return max(0,0.01 - (0.04 * L.get_skill_power(SKILL_RANGED)))