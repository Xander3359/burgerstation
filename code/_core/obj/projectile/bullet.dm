/obj/projectile/bullet/
	name = "bullet"
	impact_effect_turf = /obj/effect/temp/impact/bullet
	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID

	muzzleflash_effect = /obj/effect/temp/muzzleflash/
	alpha = 255

/obj/projectile/bullet/update_icon()
	. = ..()
	color = bullet_color

/obj/projectile/bullet/bolt
	name = "crossbow bolt"
	icon = 'icons/obj/projectiles/bolt.dmi'
	icon_state = "bolt"
	muzzleflash_effect = null

/obj/projectile/bullet/arrow
	name = "arrow"
	icon = 'icons/obj/projectiles/arrow.dmi'
	icon_state = "normal"
	muzzleflash_effect = null

/obj/projectile/bullet/arrow/ashen
	name = "arrow"
	icon = 'icons/obj/projectiles/arrow.dmi'
	icon_state = "ashen"

/obj/projectile/bullet/arrow/hardlight
	name = "arrow"
	icon = 'icons/obj/projectiles/arrow.dmi'
	icon_state = "hardlight"

/obj/projectile/bullet/arrow/hardlight/syndicate
	name = "arrow"
	icon = 'icons/obj/projectiles/arrow.dmi'
	icon_state = "hardlight_syndicate"

/obj/projectile/bullet/tungsten
	name = "tungsten bolt"
	icon = 'icons/obj/projectiles/bolt.dmi'
	icon_state = "tungsten"

/obj/projectile/bullet/syringe
	name = "launched syringe"
	icon = 'icons/obj/projectiles/bolt.dmi'
	icon_state = "syringe"
	reagents = /reagent_container/syringe_gun_syringe

/obj/projectile/bullet/syringe/on_projectile_hit(var/atom/hit_atom,var/turf/old_loc,var/turf/new_loc)

	. = ..()

	if(. &&  src.reagents && hit_atom.reagents && owner && !owner.qdeleting && is_living(hit_atom))
		if(hostile) //Has bad reagents.
			if(!allow_hostile_action(loyalty_tag,hit_atom))
				return .
		else //Has good reagents.
			if(!allow_helpful_action(loyalty_tag,hit_atom))
				return .
		src.reagents.transfer_reagents_to(hit_atom.reagents)

/obj/projectile/bullet/rocket_he

	icon = 'icons/obj/projectiles/rocket.dmi'
	icon_state = "rocket_he"
	hit_target_turf = TRUE

/obj/projectile/bullet/rocket_he/on_projectile_hit(var/atom/hit_atom,var/turf/old_loc,var/turf/new_loc)
	. = ..()
	if(. && old_loc)
		explode(old_loc,6,owner,weapon,iff_tag,multiplier = 5)

/obj/projectile/bullet/rocket_nuclear

	icon = 'icons/obj/projectiles/rocket.dmi'
	icon_state = "rocket_nuke"
	hit_target_turf = TRUE

/obj/projectile/bullet/rocket_nuclear/on_projectile_hit(var/atom/hit_atom,var/turf/old_loc,var/turf/new_loc)
	. = ..()
	if(. && old_loc)
		explode(old_loc,10,owner,weapon,iff_tag)

/obj/projectile/bullet/rocket_ap

	icon = 'icons/obj/projectiles/rocket.dmi'
	icon_state = "rocket_ap"

/obj/projectile/bullet/rocket_ap/on_projectile_hit(var/atom/hit_atom,var/turf/old_loc,var/turf/new_loc)
	. = ..()
	if(. && old_loc)
		explode(old_loc,3,owner,weapon,iff_tag)

/obj/projectile/bullet/rocket_wp

	icon = 'icons/obj/projectiles/rocket.dmi'
	icon_state = "rocket_wp"

/obj/projectile/bullet/rocket_wp/update_projectile(var/tick_rate=1)
	. = ..()
	if(.)
		vel_x *= 0.99
		vel_y *= 0.99
		alpha = clamp(alpha-5,0,255)

		if(abs(vel_x) <= 1	&& abs(vel_y) <= 1)
			on_projectile_hit(current_loc)
			return FALSE

/obj/projectile/bullet/rocket_wp/on_projectile_hit(var/atom/hit_atom,var/turf/old_loc,var/turf/new_loc)
	. = ..()
	if(. && old_loc)
		explode(old_loc,3,owner,weapon,iff_tag,multiplier = 2)
		firebomb(old_loc,22,owner,weapon,iff_tag,multiplier = 1.5)

/obj/projectile/bullet/rocket_wp/on_enter_tile(var/turf/old_loc,var/turf/new_loc)
	. = ..()
	var/obj/effect/temp/hazard/flamethrowerfire = locate() in new_loc

	if(!flamethrowerfire)
		new /obj/effect/temp/hazard/flamethrowerfire(new_loc,30 SECONDS,owner)

/obj/projectile/bullet/gyrojet
	name = "gyrojet"
	icon = 'icons/obj/projectiles/rocket.dmi'
	icon_state = "gyrojet"

/obj/projectile/bullet/gyrojet/on_projectile_hit(var/atom/hit_atom,var/turf/old_loc,var/turf/new_loc)
	. = ..()
	if(. && old_loc)
		explode(old_loc,3,owner,weapon,iff_tag)


/obj/projectile/bullet/gyrojet/update_projectile(var/tick_rate=1)

	. = ..()

	if(.)

		var/vel_x_change = vel_x * 0.05
		var/vel_y_change = vel_y * 0.05

		if(prob(50))
			vel_x += clamp(vel_y_change * rand(-1,1),-(TILE_SIZE-1),TILE_SIZE-1)

		if(prob(50))
			vel_y += clamp(vel_x_change * rand(-1,1),-(TILE_SIZE-1),TILE_SIZE-1)

		if(abs(vel_x) <= 1	&& abs(vel_y) <= 1)
			on_projectile_hit(current_loc)
			return FALSE

/obj/projectile/bullet/Fiendish
	name = "bullet"
	icon = 'icons/obj/projectiles/laser.dmi'
	icon_state = "ion"


/obj/projectile/bullet/flintlock
	name = "bullet"
	icon = 'icons/obj/projectiles/flintlock.dmi'
	icon_state = "iron"
