/mob/proc/on_life_client()
	if(!initialized)
		return FALSE
	handle_movement(CLIENT_TICK)
	return TRUE



/mob/proc/get_lighting_alpha()
	return 255

#define NIGHTVISION_TIME 2 SECONDS

/mob/proc/handle_lighting_alpha()

	//Honestly a pretty weird proc, but it werks.
	//What it does is check the alpha, and if it's a match, animate it.
	//In case of pesky race conditions, it will keep calling if the alpha is not correct.
	//If it's the same, then no alterations are needed.

	if(!plane_master_lighting)
		return FALSE
	var/night_vision_timer
	if(timeleft(night_vision_timer))
		return FALSE

	var/desired_lighting_alpha = get_lighting_alpha()

	if(plane_master_lighting.alpha != desired_lighting_alpha)
		animate(plane_master_lighting,alpha=desired_lighting_alpha,time=NIGHTVISION_TIME)
		night_vision_timer = addtimer(CALLBACK(src, PROC_REF(handle_lighting_alpha)), NIGHTVISION_TIME)

	return TRUE
