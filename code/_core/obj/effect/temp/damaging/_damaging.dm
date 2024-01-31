/obj/effect/temp/hazard
	name = "hazard"
	desc = "Avoid this."
	duration = 3 SECONDS

	var/atom/owner

	var/hazard_range = 0
	var/hazard_delay = 1 SECONDS

	var/cross_hazard = TRUE

	var/enabled = FALSE

	density = TRUE

	hazardous = TRUE

	var/cross_damage_timer

/obj/effect/temp/hazard/Destroy()
	owner = null
	return ..()

/obj/effect/temp/hazard/proc/activate_hazard()
	enabled = TRUE
	do_hazard()
	return TRUE

/obj/effect/temp/hazard/proc/deactivate_hazard()
	return TRUE

/obj/effect/temp/hazard/New(desired_location, desired_time, desired_owner)

	if(desired_owner)
		owner = desired_owner

	if(hazard_delay <= 0)
		activate_hazard()
	else
		addtimer(CALLBACK(src, PROC_REF(activate_hazard)), hazard_delay)

	return ..()


/obj/effect/temp/hazard/proc/do_cross_damage(mob/living/L)

	if(!cross_hazard || !enabled || !L || L.loc != src.loc)
		return FALSE

	do_damage(L)

	if(!timeleft(cross_damage_timer))
		cross_damage_timer = addtimer(CALLBACK(src, PROC_REF(do_cross_damage), L), 1 SECONDS)

/obj/effect/temp/hazard/Crossed(atom/movable/O,atom/OldLoc)
	if(enabled && cross_hazard && is_living(O))
		do_cross_damage(O)
	return ..()

/obj/effect/temp/hazard/Uncrossed(atom/movable/O)
	if(enabled && cross_hazard && is_living(O))
		do_cross_damage(O)
	return ..()

/obj/effect/temp/hazard/proc/get_params(atom/victim)
	. = list()
	.[PARAM_ICON_X] = rand(0,32)
	.[PARAM_ICON_Y] = rand(0,32)

/obj/effect/temp/hazard/proc/do_damage(atom/victim)
	var/damagetype/DT = SSdamagetype.all_damage_types[damage_type]
	var/list/params = get_params()
	if(!victim.can_be_attacked(owner,src,params,DT))
		return FALSE
	var/atom/object_to_damage = victim.get_object_to_damage(owner,src,damage_type,params,TRUE,TRUE)
	return DT.process_damage(owner,victim,src,object_to_damage,owner,1)

/obj/effect/temp/hazard/proc/do_hazard()

	if(qdeleting)
		return FALSE

	if(hazard_range >= 2)
		for(var/mob/living/L in range(hazard_range,src))
			do_damage(L)
	else
		var/turf/T = get_turf(src)
		if(T)
			for(var/mob/living/L in T.contents)
				do_damage(L)


/obj/effect/temp/hazard/falling_fireball
	name = "falling fireball"
	icon = 'icons/obj/projectiles/magic.dmi'
	icon_state = "firebolt"
	duration = 2.1 SECONDS
	hazard_range = 0
	hazard_delay = 2 SECONDS
	damage_type = /damagetype/ranged/magic/fireball

/obj/effect/temp/hazard/falling_fireball/New(desired_location,desired_time,desired_owner)

	alpha = 50
	pixel_z = TILE_SIZE*VIEW_RANGE

	src.transform = turn(src.transform, 180)

	animate(src,alpha=255,time=hazard_delay*0.5)
	animate(src,pixel_z=0,time=hazard_delay*0.9)

	return ..()

/obj/effect/temp/hazard/tentacle/
	name = "goliath tentacle"
	icon = 'icons/mob/living/simple/lavaland/goliath.dmi'
	icon_state = "tentacle"
	duration = 13
	hazard_delay = 7

	hazard_range = 0
	damage_type = /damagetype/npc/goliath_tentacle
	cross_hazard = TRUE

	layer = LAYER_FLOOR_EFFECTS

/obj/effect/temp/hazard/tentacle/New(desired_location,desired_time,desired_owner)
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(deactivate_hazard)), 9)

/obj/effect/temp/hazard/tentacle/attack(atom/attacker,atom/victim,list/params=list(),atom/blamed,ignore_distance = FALSE, precise = FALSE,damage_multiplier=1,damagetype/damage_type_override)
	if(istype(victim,/mob/living/simple/goliath/)) //This bug is hilarious but we don't want to have it.
		return FALSE
	return ..()

/obj/effect/temp/hazard/bubblefist/
	name = "bubblegum grab"
	icon = 'icons/mob/living/simple/lavaland/bubblegum_hands.dmi'
	icon_state = "rightpawgrab"
	var/overlay_state = "rightthumbgrab"
	duration = 10
	hazard_delay = 6

	hazard_range = 0
	damage_type = /damagetype/npc/goliath_tentacle
	cross_hazard = TRUE

	layer = LAYER_FLOOR_EFFECTS

	plane = PLANE_MOVABLE - 1

/obj/effect/temp/hazard/bubblefist/update_overlays()
	. = ..()
	var/image/I = new/image(icon,overlay_state)
	I.appearance_flags = src.appearance_flags
	I.plane = PLANE_EFFECT
	add_overlay(I)

/obj/effect/temp/hazard/bubblefist/New(desired_location,desired_time,desired_owner)
	if(prob(50))
		icon_state = "leftpawgrab"
		overlay_state = "leftthumbgrab"
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(deactivate_hazard)), 7)
	update_sprite()

/obj/effect/temp/hazard/bubblefist/attack(atom/attacker,atom/victim,list/params=list(),atom/blamed,ignore_distance = FALSE, precise = FALSE,damage_multiplier=1,damagetype/damage_type_override)
	if(istype(victim,/mob/living/simple/bubblegum)) //This bug is hilarious but we don't want to have it.
		return FALSE
	return ..()



/obj/effect/temp/hazard/lava/
	name = "lava"
	icon = 'icons/obj/effects/lava.dmi'
	icon_state = "lavastaff_warn"
	duration = 30 SECONDS
	hazard_range = 1
	damage_type = /damagetype/ranged/magic/fireball
	cross_hazard = TRUE
	plane = PLANE_BLOOD
	layer = LAYER_FLOOR_EFFECTS

/obj/effect/temp/hazard/lava/get_params(atom/victim)

	if(is_living(victim))
		var/mob/living/L = victim
		if(L.horizontal)
			return ..()

	. = list()
	.[PARAM_ICON_X] = rand(0,32)
	.[PARAM_ICON_Y] = rand(0.14)


/obj/effect/temp/hazard/curse
	name = "lava"
	icon = 'icons/obj/structure/cult/effects.dmi'
	icon_state = "floorglow_strong"
	duration = 10 SECONDS
	hazard_range = 1
	damage_type = /damagetype/ranged/magic/cult
	cross_hazard = TRUE
	plane = PLANE_BLOOD
	layer = LAYER_FLOOR_EFFECTS

/obj/effect/temp/hazard/curse/New(desired_location,desired_time,desired_owner)

	if(istype(desired_location,/turf/simulated/wall/))
		icon_state = "wallglow_strong"

	return ..()

/obj/effect/temp/hazard/curse/get_params(atom/victim)

	if(is_living(victim))
		var/mob/living/L = victim
		if(L.horizontal)
			return ..()

	. = list()
	.[PARAM_ICON_X] = rand(0,32)
	.[PARAM_ICON_Y] = rand(0,14)

/obj/effect/temp/hazard/flamethrowerfire
	name = "fire"
	icon = 'icons/obj/effects/flamer_fire_effect.dmi' //FIRE
	icon_state = "red_1" //brain out, soup in
	duration = 30 SECONDS
	hazard_range = 1
	damage_type = /damagetype/ranged/laser/flamethrower
	cross_hazard = TRUE
	plane = PLANE_BLOOD
	layer = LAYER_FLOOR_EFFECTS

/obj/effect/temp/hazard/flamethrowerfire/get_params(atom/victim)

	if(is_living(victim))
		var/mob/living/L = victim
		if(L.horizontal)
			return ..()

	. = list()
	.[PARAM_ICON_X] = rand(0,32)
	.[PARAM_ICON_Y] = rand(0.14)
