/mob/living/simple/silicon/spawner
	name = "cyborg spawner"
	icon = 'icons/mob/living/simple/ai.dmi'
	icon_state = "spawner"

	anchored = TRUE
	ai = /ai/silicon_spawner

	health_base = 300

	var/list/active_silicons = list()

	var/silicon_limit = 3

	pixel_y = 10

	stun_angle = 0
	stun_elevation = 0

	var/has_stored_cyborg = FALSE

	///Start creating timer
	var/start_creating_timer
	///Create silicon timer
	var/create_silicon_timer

/mob/living/simple/silicon/spawner/Destroy()
	. = ..()
	active_silicons.Cut()
	active_silicons = null

/mob/living/simple/silicon/spawner/Finalize()
	. = ..()
	pixel_y = 0
	animate(src,pixel_y=initial(pixel_y),time=10)
	flick("spawner_new",src)
	start_creating()

/mob/living/simple/silicon/spawner/post_death()
	. = ..()
	icon_state = "[initial(icon_state)]_destroyed"

/mob/living/simple/silicon/spawner/proc/start_creating()

	if(dead || qdeleting)
		return FALSE

	for(var/k in active_silicons)
		var/mob/living/L = k
		if(!L || L.dead || L.qdeleting)
			active_silicons -= L

	if(length(active_silicons) > silicon_limit)
		start_creating_timer = addtimer(CALLBACK(src, PROC_REF(start_creating)), 10 SECONDS)
		return FALSE

	icon_state = "[initial(icon_state)]_creating"

	create_silicon_timer = addtimer(CALLBACK(src, PROC_REF(create_silicon)), 20 SECONDS)

	return TRUE

/mob/living/simple/silicon/spawner/proc/create_silicon()

	if(dead || qdeleting)
		return FALSE

	if(!ai || !ai.objective_attack)
		has_stored_cyborg = TRUE
		icon_state = "[initial(icon_state)]_creating"
		return TRUE //Don't continue the process. It is continued when an objective is set.

	icon_state = "[initial(icon_state)]_open"

	var/mob/living/simple/silicon/cyborg/SM = new(src.loc)
	INITIALIZE(SM)
	GENERATE(SM)
	FINALIZE(SM)
	if(SM.ai)
		SM.ai.set_active(TRUE)
		SM.ai.queue_find_new_objectives = TRUE
		SM.ai.roaming_distance = VIEW_RANGE*0.5
		SM.ai.allow_far_roaming = FALSE
	SM.Move(get_step(SM,SOUTH))
	active_silicons += SM
	has_stored_cyborg = FALSE

	start_creating_timer = addtimer(CALLBACK(src, PROC_REF(start_creating)), 20 SECONDS)

	return TRUE
