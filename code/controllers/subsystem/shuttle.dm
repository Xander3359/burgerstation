SUBSYSTEM_DEF(shuttle) //Also controls drop pods.
	name = "Shuttle Subsystem"
	desc = "Controls shuttles and shuttle timers."
	wait = SECONDS_TO_TICKS(1)
	priority = SS_ORDER_NORMAL


	var/next_pod_respawn_time = 0

	var/global_shuttle_number = 0

	var/list/obj/structure/interactive/computer/console/shuttle_landing/all_shuttle_landing_consoles = list()

	var/list/obj/marker/shuttle_landing/all_shuttle_landing_markers = list()

	var/list/obj/structure/interactive/drop_pod/all_drop_pods = list()
	var/list/turf/drop_pod_turfs = list() //Drop pods that need to respawn.

	var/list/all_shuttle_controlers = list()

/datum/controller/subsystem/shuttle/Initialize()
	log_subsystem(src.name,"Found [length(all_shuttle_controlers)] shuttle controllers.")
	return ..()


/datum/controller/subsystem/shuttle/unclog(mob/caller)

	for(var/k in all_shuttle_controlers)
		var/obj/shuttle_controller/SC = k
		if(!SC || SC.qdeleting)
			all_shuttle_controlers -= k
			continue
		qdel(SC)

	. = ..()

/datum/controller/subsystem/shuttle/on_life()

	for(var/k in all_shuttle_controlers)
		var/obj/shuttle_controller/SC = k
		if(!SC || SC.qdeleting)
			all_shuttle_controlers -= k
			continue
		SC.time++
		if(SC.on_shuttle_think() == null)
			log_error("Shutting down controller for [SC]([SC.x])([SC.y])([SC.z]) as on_shuttle_think returned NULL!")
			all_shuttle_controlers -= SC
			qdel(SC)
		CHECK_TICK

	if(next_pod_respawn_time <= world.time)
		for(var/k in drop_pod_turfs)
			var/turf/T = k
			if(!T)
				drop_pod_turfs -= k
				continue
			CREATE(/obj/structure/interactive/drop_pod,T)
			drop_pod_turfs -= k
			CHECK_TICK
		next_pod_respawn_time = world.time + 120 SECONDS

	return TRUE
