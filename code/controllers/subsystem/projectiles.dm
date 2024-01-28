

SUBSYSTEM_DEF(projectiles)
	name = "Projectile Subsystem"
	desc = "Controls projectiles."
	wait = PROJECTILE_TICK
	priority = SS_ORDER_IMPORTANT

	var/list/obj/projectile/all_projectiles = list()

/datum/controller/subsystem/projectiles/unclog(mob/caller)

	for(var/k in all_projectiles)
		var/obj/projectile/P = k
		all_projectiles -= k
		if(!P || P.qdeleting)
			continue
		qdel(P)

	return ..()

/datum/controller/subsystem/projectiles/on_life()

	for(var/k in all_projectiles)
		var/obj/projectile/P = k
		var/result = P.update_projectile(wait)
		if(result)
			CHECK_TICK
			continue
		if(result == null)
			log_error("Warning! Projectile [P.get_debug_name()] didn't run update_projectile properly, and thus was deleted.")
		qdel(P) //Remove is called inside the projectile
		CHECK_TICK

	return TRUE
