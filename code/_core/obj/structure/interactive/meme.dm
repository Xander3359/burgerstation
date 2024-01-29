/obj/structure/interactive/dont_look
	name = "made you look"
	desc = "HA, GOTTEEM!"
	desc_extended = "A special structure that does something bad when you look-- You looked, too late."
	icon = 'icons/obj/item/meme.dmi'
	icon_state = "lol"
	///Explode timer
	var/explode_timer

/obj/structure/interactive/dont_look/Finalize()
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(callback_delete)), 60 SECONDS)
	if(is_turf(src.loc))
		START_THINKING(src)

/obj/structure/interactive/dont_look/proc/callback_delete()
	qdel(src)
	return TRUE

/obj/structure/interactive/dont_look/think()
	if(!is_turf(src.loc))
		..()
		return FALSE
	check_look() //I mean, it's an admin item. Who care if it's intensive?
	. = ..()

/obj/structure/interactive/dont_look/post_move(atom/old_loc)
	. = ..()
	if(is_turf(src.loc) && !is_turf(old_loc))
		START_THINKING(src)

/obj/structure/interactive/dont_look/proc/do_explode()
	var/turf/T = get_turf(src)
	explode(T,VIEW_RANGE,T,T,"God")
	qdel(src)
	return TRUE

/obj/structure/interactive/dont_look/proc/check_look()

	if(timeleft(explode_timer))
		return FALSE

	var/found_viewers = 0

	for(var/mob/living/L in viewers(VIEW_RANGE,get_turf(src)))
		if(L.dead)
			continue
		L.visible_message("<b>\The [L.name]</b> looked!")
		L.do_emote("scream")
		found_viewers += 1

	if(found_viewers > 0)
		explode_timer = addtimer(CALLBACK(src, PROC_REF(do_explode)), 1 SECONDS)
		return TRUE

	return FALSE
