SUBSYSTEM_DEF(ghost)
	name = "Ghost Subsystem"
	desc = "Controls ghost related stuff."
	priority = SS_ORDER_LAST
	wait = SECONDS_TO_TICKS(1)


	var/list/obj/item/emf/all_emf_trackers = list()
	var/list/obj/emf/all_emfs = list()

/datum/controller/subsystem/ghost/unclog(mob/caller)

	for(var/k in all_emfs)
		var/obj/emf/E = k
		all_emfs -= k
		if(!E || E.qdeleting)
			continue
		qdel(E)

	for(var/k in all_emf_trackers)
		var/obj/item/emf/E = k
		all_emf_trackers -= k
		if(!E || E.qdeleting)
			continue
		qdel(E)

	return ..()

/datum/controller/subsystem/ghost/on_life()

	for(var/k in all_emf_trackers)
		var/obj/item/emf/E = k
		if(!E || E.qdeleting)
			all_emfs -= k
			continue
		E.on_emf_think()
		CHECK_TICK

	for(var/k in all_emfs)
		var/obj/emf/E = k
		if(!E || E.qdeleting)
			all_emfs -= k
			continue
		if(E.time_to_delete <= world.time)
			qdel(E)
		CHECK_TICK

	return TRUE
