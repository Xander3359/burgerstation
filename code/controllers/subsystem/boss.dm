SUBSYSTEM_DEF(bosses)
	name = "Boss Subsystem"
	desc = "Tracks which players are bossfighting someone."
	wait = SECONDS_TO_TICKS(4)
	priority = SS_ORDER_FIRST
	var/list/tracked_bosses = list()
	var/list/living_bosses = list()

	var/list/tracked_rogue_crewmembers = list()

/datum/controller/subsystem/bosses/unclog(mob/caller)

	. = ..()

	for(var/k in tracked_bosses)
		var/mob/living/L = k
		tracked_bosses -= k
		if(!L || L.qdeleting)
			continue
		L.gib()


/datum/controller/subsystem/bosses/proc/check_boss(mob/living/L)

	if(L.dead || L.qdeleting)
		for(var/v in L.players_fighting_boss)
			var/mob/living/advanced/P = v
			if(!P || P.qdeleting)
				L.players_fighting_boss -= v
				continue
			L.remove_player_from_boss(P)
			CHECK_TICK
		return FALSE

	if(L.ai)
		var/ai/AI = L.ai
		if(AI.objective_attack)
			for(var/mob/living/advanced/player/P in viewers(L.boss_range,L))
				CHECK_TICK
				L.add_player_to_boss(P)

	for(var/v in L.players_fighting_boss)
		var/mob/living/advanced/player/P = v
		CHECK_TICK
		if(get_dist(P,L) >= L.boss_range*2)
			L.remove_player_from_boss(P)

	return TRUE

/datum/controller/subsystem/bosses/on_life()

	for(var/k in tracked_bosses)
		var/mob/living/L = k
		if(!L)
			tracked_bosses -= k
			continue
		if(check_boss(L) == null)
			tracked_bosses -= L
			qdel(L)
			log_error("WARNING! Boss [L.get_debug_name()] didn't complete tracked_bosses() and thus was deleted.")
		CHECK_TICK

	return TRUE

/mob/living/proc/update_boss_health()
	for(var/k in players_fighting_boss)
		var/mob/living/advanced/P = k
		for(var/obj/hud/button/boss_health/B in P.buttons)
			B.target_bosses |= src
			B.update_stats()

/mob/living/proc/add_player_to_boss(mob/living/advanced/player/P)
	if(P in src.players_fighting_boss)
		return FALSE
	players_fighting_boss += P
	for(var/obj/hud/button/boss_health/B in P.buttons)
		B.target_bosses |= src
		B.update_stats()

/mob/living/proc/remove_player_from_boss(mob/living/advanced/player/P)
	if(!(P in src.players_fighting_boss))
		return FALSE
	players_fighting_boss -= P
	for(var/obj/hud/button/boss_health/B in P.buttons)
		B.target_bosses -= src
		B.update_stats()
