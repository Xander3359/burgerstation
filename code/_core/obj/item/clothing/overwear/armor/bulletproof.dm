/obj/item/clothing/overwear/armor/bulletproof
	name = "bulletproof armor"
	icon = 'icons/obj/item/clothing/suit/bulletproof_vest.dmi'
	desc = "Protecting against the greytide since 2193."
	desc_extended = "A sturdy chestplate of bulletproof armor. Should protect against most small arms fire."

	protected_limbs = list(BODY_TORSO)

	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = 20,
		BLUNT = AP_CLUB,
		PIERCE = 40,
		LASER = -40,
		ARCANE = -40,
		PAIN = 40
	)

	size = SIZE_4


	value = 200