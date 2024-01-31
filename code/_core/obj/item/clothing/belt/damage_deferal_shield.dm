/obj/item/clothing/belt/damage_deferal_shield
	name = "alien-portable shield"
	desc = "For the aspiring supersoldier."
	desc_extended = "An alien-tech belt-worn damage mitigation system with a mini-fusion reactor that redirects most lethal kinetic energy away from the user. \
	Requires an absurd amount of power to operate, thus it only activates after detecting the first hit and shuts off after taking more than 200 damage, after 8 seconds, or until the user manually shuts it off. \
	Has a cooldown of 10 seconds before it can be used again."

	icon = 'icons/obj/item/clothing/belts/damage_deferal.dmi'
	worn_layer = LAYER_MOB_CLOTHING_COAT_OVER
	dyeable = FALSE

	value = 1800
	size = SIZE_4
	weight = 30

	can_negate_damage = TRUE

	var/damage_limit = 200
	var/active_time = 8 SECONDS //How long the shield stays active for.
	var/cooldown_time = 10 SECONDS //How long it takes for the shield to reactivate.

	var/obj/effect/shield_overlay

	protected_limbs = TARGETABLE_LIMBS

	uses_until_condition_fall = 1000

	contraband = TRUE

	rarity = RARITY_MYTHICAL

	var/shield_disable_timer
	var/shield_cooldown_timer
	var/shield_beep_timer

/obj/item/clothing/belt/damage_deferal_shield/use_condition(amount_to_use=1)
	if(!(timeleft(shield_disable_timer)))
		return FALSE
	. = ..()


/obj/item/clothing/belt/damage_deferal_shield/on_equip(atom/old_location,silent=FALSE)
	. = ..()
	var/obj/hud/inventory/I = loc
	if(I.worn && is_advanced(I.owner))
		HOOK_ADD("post_move","\ref[src]_shield_post_move",I.owner,src,src::owner_post_move())

/obj/item/clothing/belt/damage_deferal_shield/on_unequip(obj/hud/inventory/old_inventory,silent=FALSE) //When the object is dropped from the old_inventory
	. = ..()
	if(old_inventory.worn && is_advanced(old_inventory.owner))
		HOOK_REMOVE("post_move","\ref[src]_shield_post_move",old_inventory.owner)

/obj/item/clothing/belt/damage_deferal_shield/proc/owner_post_move(mob/living/advanced/owner,atom/old_loc)
	shield_overlay.glide_size = owner.glide_size
	shield_overlay.force_move(owner.loc)
	return TRUE

/obj/item/clothing/belt/damage_deferal_shield/New(desired_loc)
	. = ..()
	shield_overlay = new(src)
	shield_overlay.mouse_opacity = 0
	shield_overlay.icon = icon
	shield_overlay.icon_state = "overlay"
	shield_overlay.alpha = 0

/obj/item/clothing/belt/damage_deferal_shield/PreDestroy()
	deltimer(shield_disable_timer)
	deltimer(shield_cooldown_timer)
	deltimer(shield_beep_timer)
	QDEL_NULL(shield_overlay)
	. = ..()

/obj/item/clothing/belt/damage_deferal_shield/click_self(mob/caller,location,control,params)

	if(timeleft(shield_disable_timer))
		caller.to_chat(span("notice","You toggle \the [src.name] off and manually cycle the shield."))
		deltimer(shield_disable_timer)
		disable_shield()
	else if(timeleft(shield_cooldown_timer))
		caller.to_chat(span("warning","The interface flickers an error as it is still cooling down!"))
	else
		caller.to_chat(span("notice","You toggle \the [src.name] on and activate the shield."))
		shield_disable_timer = addtimer(CALLBACK(src, PROC_REF(disable_shield)), active_time, TIMER_STOPPABLE) //Activate the shield!

	update_sprite()

	return TRUE

/obj/item/clothing/belt/damage_deferal_shield/update_sprite()

	. = ..()

	icon = initial(icon)
	icon_state = initial(icon_state)

	if(timeleft(shield_cooldown_timer)) //Shield that is cooling down.
		icon_state = "[icon_state]_cooling"
	else if(timeleft(shield_disable_timer)) //Active shield.
		icon_state = "[icon_state]_active"

/obj/item/clothing/belt/damage_deferal_shield/proc/disable_shield()
	damage_limit = initial(damage_limit)
	shield_cooldown_timer = addtimer(CALLBACK(src, PROC_REF(cooldown_end)), cooldown_time, TIMER_STOPPABLE)
	shield_beep()
	update_sprite()
	return TRUE

/obj/item/clothing/belt/damage_deferal_shield/proc/shield_beep()
	if(!timeleft(shield_beep_timer)) //Only beep if there is a cooldown.
		return FALSE
	play_sound('sound/effects/shield_beep.ogg',get_turf(src))
	shield_beep_timer = addtimer(CALLBACK(src, PROC_REF(shield_beep)), 1 SECONDS, TIMER_STOPPABLE)
	return TRUE


/obj/item/clothing/belt/damage_deferal_shield/proc/cooldown_end()
	play_sound('sound/effects/shield_recharge.ogg',get_turf(src))
	update_sprite()
	return TRUE

/obj/item/clothing/belt/damage_deferal_shield/negate_damage(atom/attacker,atom/victim,atom/weapon,atom/hit_object,atom/blamed,damage_dealt=0)

	if(damage_dealt <= 0) //The damage doesn't exist for some reason.
		return FALSE

	if(damage_limit <= 0) //No damage can be protected!
		return FALSE

	if(timeleft(shield_cooldown_timer)) //Cooling down, can't do anything right now.
		return FALSE

	if(!timeleft(shield_disable_timer)) //The shield is not active.
		shield_disable_timer = addtimer(CALLBACK(src, PROC_REF(disable_shield)), active_time, TIMER_STOPPABLE) //Activate the shield!
		return FALSE

	animate(shield_overlay,alpha=clamp(damage_dealt+100,100,255),time=0,flags=ANIMATION_END_NOW )
	animate(alpha=0,time=5)

	damage_limit -= damage_dealt

	if(damage_limit <= 0)
		deltimer(shield_disable_timer)
		disable_shield()
		return FALSE

	return TRUE


