/obj/item/clothing/feet/shoes/boot_colored
	name = "right colored boot"
	desc = "For when you want to turn up the heat a little."
	desc_extended = "A black combat boot. Shields your feet from shrapnel."

	icon_state = "inventory_right"
	icon_state_worn = "worn_right"
	worn_layer = LAYER_MOB_CLOTHING_BELT

	icon = 'icons/obj/item/clothing/shoes/boots_poly.dmi'

	defense_rating = list(
		BLADE = 40,
		BLUNT = 40,
		PIERCE = 40,
		LASER = -40,
		ARCANE = -40,
		COLD = 40,
		BOMB = 40,
		PAIN = 40
	)

	size = SIZE_2

	value = 60

	speed_bonus = 0

/obj/item/clothing/feet/shoes/boot_colored/left
	name = "left colored boot"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT
	item_slot_mod = SLOT_MOD_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)

/obj/item/clothing/feet/shoes/boot_colored/merc
	color = "#4D4F43"

/obj/item/clothing/feet/shoes/boot_colored/merc/left
	name = "left colored boot"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT
	item_slot_mod = SLOT_MOD_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)
