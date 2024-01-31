/obj/structure/interactive/slime_tile
	name = "slimed tile"
	icon = 'icons/obj/effects/slime_tile.dmi'
	icon_state = "tile"

	collision_bullet_flags = FLAG_COLLISION_BULLET_SPECIFIC

	density = 1
	anchored = 1

	mouse_opacity = 2

	color = "#0094FF"

	health = /health/construction
	health_base = 25

	plane = PLANE_WIRE
	layer = LAYER_FLOOR_CARPET + 10

	alpha = 150

	var/permanent = FALSE

	///timer for the tile to delete itself
	var/self_delete_timer

/obj/structure/interactive/slime_tile/permanent
	permanent = TRUE

/obj/structure/interactive/slime_tile/Finalize()
	. = ..()
	var/original_color = color
	var/matrix/M = matrix()
	M.Scale(0)
	transform = M
	color = "#FFFFFF"
	animate(
		src,
		transform=get_base_transform(),
		color=original_color,
		pixel_z = 6,
		time=10
	)
	animate(
		pixel_z = 0,
		time = 5
	)
	if(!permanent)
		adddtimer(CALLBACK(src, PROC_REF(telegraph_delete)), 300)

/obj/structure/interactive/slime_tile/proc/telegraph_delete()
	if(src.qdeleting)
		return FALSE
	var/matrix/M = matrix()
	M.Scale(0)
	animate(src,transform=M,alpha=0,time=20)
	self_delete_timer = addtimer(CALLBACK(src, PROC_REF(do_delete)), 20)

/obj/structure/interactive/slime_tile/proc/do_delete()
	if(src.qdeleting)
		return FALSE
	qdel(src)
	return TRUE


/obj/structure/interactive/slime_tile/proc/heal(mob/living/L)

	if(src.qdeleting || L.qdeleting)
		return FALSE

	if(L.loc != src.loc)
		return FALSE

	if(L.dead)
		return FALSE

	if(L.brute_regen_buffer <= 5)
		L.brute_regen_buffer = min(L.brute_regen_buffer + 5,5)

	if(L.burn_regen_buffer <= 5)
		L.burn_regen_buffer = min(L.burn_regen_buffer + 5,5)

	var/obj/effect/temp/healing/H = new(src.loc)
	H.color = src.color
	INITIALIZE(H)
	GENERATE(H)
	FINALIZE(H)

	addtimer(CALLBACK(src, PROC_REF(heal), L), 10)

	return TRUE

/obj/structure/interactive/slime_tile/Crossed(atom/movable/O,atom/OldLoc)
	. = ..()
	if(!src.qdeleting && !timeleft(self_delete_timer) && is_living(O))
		var/mob/living/L = O
		if(L.loyalty_tag == "Slime")
			addtimer(CALLBACK(src, PROC_REF(heal), L), 10)
		else
			L.add_status_effect(SLOW,20,20)
			play_sound('sound/effects/slimed.ogg',get_turf(src))
			telegraph_delete()

/obj/structure/interactive/slime_tile/on_destruction(damage = TRUE)
	. = ..()
	qdel(src)