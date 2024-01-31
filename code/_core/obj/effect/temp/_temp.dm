/obj/effect/temp
	name = "temp effect"
	desc = "Effect that gets deleted after a while."
	var/duration = 10 //Deciseconds
	///Timer for temporary effects
	var/temp_effect_timer

/obj/effect/temp/PreDestroy()
	deltimer(temp_effect_timer)
	. = ..()

/obj/effect/temp/New(desired_location, desired_time)

	. = ..()

	if(desired_time)
		duration = desired_time

	temp_effect_timer = addtimer(CALLBACK(src, PROC_REF(remove_effect)), duration, TIMER_STOPPABLE)

/obj/effect/temp/proc/remove_effect()
	qdel(src)
	return TRUE