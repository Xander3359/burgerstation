#define within_range(point_A,point_B,range) (point_A.z == point_B.z && get_dist(point_A,point_B) <= range)

/proc/create_alert_process(list/list_to_use, range = VIEW_RANGE, atom/epicenter, atom/alert_source, alert_level = ALERT_LEVEL_NOISE, visual = FALSE)

	. = 0

	if(!epicenter)
		CRASH("No valid epicenter provided for create_alert_process()!")

	for(var/k in list_to_use)
		var/ai/AI = k
		if(!AI || AI.qdeleting || !AI.owner || AI.owner.qdeleting || AI.owner.dead || AI.objective_attack || AI.alert_level > alert_level)
			continue
		var/alert_timer
		var/list/callback_data = CALLBACK_EXISTS("alert_level_change_\ref[AI]")
		if(alert_timer && callback_data["args"][2] != alert_source) //Already reacting to something else.
			continue
		if(!within_range(AI.owner,epicenter,range)) //Too far away.
			continue
		if(visual && !is_facing_cheap(AI.owner,epicenter))
			continue
		if(alert_source && !AI.is_enemy(alert_source,FALSE))
			continue
		. += 1
		if(alert_timer || AI.reaction_time <= 0) //Force a reaction instantly.
			deltimer(alert_timer)
			AI.set_alert_level(alert_level,alert_source,epicenter,FALSE)
		else
			alert_timer = addtimer(CALLBACK(AI, PROC_REF(set_alert_level), alert_level, alert_source, epicenter, FALSE), CEILING(AI.reaction_time, 1), TIMER_STOPPABLE)
			CALLBACK("alert_level_change_\ref[AI]",CEILING(AI.reaction_time,1),AI,AI::set_alert_level(),alert_level,alert_source,epicenter,FALSE)



/proc/create_alert(range = VIEW_RANGE, turf/epicenter, atom/alert_source, alert_level = ALERT_LEVEL_NOISE, visual=FALSE)

	if(!epicenter)
		CRASH("create_alert() had no epicenter!")

	if(epicenter.z == 0)
		CRASH("create_alert() had a non-turf as an epicenter!")

	if(is_living(alert_source))
		var/mob/living/L = alert_source
		if(L.master)
			if(L.master.next_alert > world.time)
				return FALSE
			L.master.next_alert = world.time + 1 SECONDS
		else
			if(L.next_alert > world.time)
				return FALSE
			L.next_alert = world.time + 1 SECONDS

	. = 0

	var/chunk/CH = CHUNK(epicenter)
	if(CH)
		. += create_alert_process(CH.ai,range,epicenter,alert_source,alert_level,visual)
		for(var/k in CH.adjacent_chunks)
			var/chunk/CH2 = k
			. += create_alert_process(CH2.ai,range,epicenter,alert_source,alert_level,visual)

	return .

