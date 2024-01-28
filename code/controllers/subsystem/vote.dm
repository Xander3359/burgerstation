SUBSYSTEM_DEF(vote)
	name = "Voting Subsystem"
	desc = "Controls voting timers and other memes."
	priority = SS_ORDER_LAST
	wait = SECONDS_TO_TICKS(1)


	var/list/active_votes = list()

/datum/controller/subsystem/vote/unclog(mob/caller)

	for(var/k in active_votes)
		var/vote/V = k
		active_votes -= k
		if(!V || V.qdeleting)
			continue
		qdel(V)

	. = ..()

/datum/controller/subsystem/vote/proc/proces_vote(vote/V)
	if(V.time_to_end > world.time)
		return FALSE
	active_votes -= V
	qdel(V)
	return TRUE

/datum/controller/subsystem/vote/on_life()

	for(var/k in active_votes)
		var/vote/V = k
		if(!V || V.qdeleting)
			continue
		if(proces_vote(V) == null)
			qdel(V)
			active_votes -= k
		CHECK_TICK

	return TRUE

/datum/controller/subsystem/vote/proc/create_vote(vote/desired_vote_type)
	var/vote/V = new desired_vote_type
	active_votes += V
	V.time_to_end = world.time + (V.time_limit) SECONDS
	return V
