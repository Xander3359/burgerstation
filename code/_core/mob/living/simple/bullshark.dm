/mob/living/simple/bullshark
	name = "bullshark"
	icon = 'icons/mob/living/simple/bullshark.dmi'
	icon_state = "living"

	health_base = 200

	ai = /ai/bullshark
	class = /class/bull
	damage_type = /damagetype/unarmed/bite/

	iff_tag = "Meme"
	loyalty_tag = "Meme"

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

	mob_size = MOB_SIZE_LARGE

	blood_type = /reagent/blood/carp
	blood_volume = 750

	butcher_contents = list(
		/obj/item/container/food/dynamic/fish/raw_carp,
		/obj/item/container/food/dynamic/fish/raw_carp,
		/obj/item/container/food/dynamic/fish/raw_carp,
		/obj/item/container/food/dynamic/fish/raw_carp
	)

/mob/living/simple/bullshark/post_death()
	. = ..()
	icon_state = "dead"
	return .

