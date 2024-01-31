/obj/effect/falling_meteor
	name = "falling meteor"
	icon = 'icons/obj/effects/meteor.dmi'
	icon_state = "small"

	plane = PLANE_ALWAYS_VISIBLE

	var/meteor_time = 3 SECONDS

/obj/effect/falling_meteor/New(desired_location)

	alpha = 0
	pixel_z = TILE_SIZE*VIEW_RANGE*2
	pixel_w = TILE_SIZE*VIEW_RANGE

	var/matrix/M = get_base_transform()
	M.Scale(2,2)
	src.transform = M

	animate(src, alpha=255, time=meteor_time*0.5)
	animate(src, pixel_z=0, pixel_w=0, time=meteor_time, transform = get_base_transform())

	addtimer(CALLBACK(src, PROC_REF(create_telegraph)), meteor_time - 20)

	addtimer(CALLBACK(src, PROC_REF(land)), meteor_time)

	return ..()

/obj/effect/falling_meteor/proc/create_telegraph()
	new/obj/effect/temp/target(loc,20)

/obj/effect/falling_meteor/proc/land()
	explode(get_turf(src),2,src,src,multiplier = 5)
	src.alpha = 0
	addtimer(CALLBACK(src, TYPE_PROC_REF(/datum, delete)), 3 SECONDS)
	return TRUE

/obj/effect/falling_fireball
	name = "falling fireball"
	icon = 'icons/obj/projectiles/magic.dmi'
	icon_state = "firebolt_flipped"

	var/meteor_time = 2 SECONDS
	var/stored_loyalty_tag = "Ash Drake"

/obj/effect/falling_fireball/New(desired_location)

	alpha = 0
	pixel_z = TILE_SIZE*VIEW_RANGE*2

	var/matrix/M = get_base_transform()
	M.Scale(2,2)
	src.transform = M

	animate(src, alpha=255, time=meteor_time*0.5)
	animate(src, pixel_z=0, pixel_w=0, time=meteor_time*0.95, transform = get_base_transform())

	addtimer(CALLBACK(src, PROC_REF(land)), meteor_time)

	return ..()

/obj/effect/falling_fireball/proc/land()
	explode(get_turf(src),2,src,src,desired_loyalty_tag=stored_loyalty_tag)
	src.alpha = 0
	addtimer(CALLBACK(src, TYPE_PROC_REF(/datum, delete)), 3 SECONDS)
	return TRUE
