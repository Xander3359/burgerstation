SUBSYSTEM_DEF(ball) //Finally. A subsystem dedicated to BALLS.
	name = "Ball Subsystem"
	desc = "Controls how balls behave."
	wait = 1
	priority = SS_ORDER_LAST

	var/list/all_balls = list()

/datum/controller/subsystem/ball/unclog(mob/caller)
	for(var/k in all_balls)
		var/obj/item/ball/B = k
		if(!B || B.qdeleting)
			all_balls -= k
			continue
		qdel(B)
	. = ..()

/datum/controller/subsystem/ball/on_life()

	for(var/k in all_balls)
		var/obj/item/ball/B = k
		B.ball_think(tick_rate)
		CHECK_TICK

	return TRUE


