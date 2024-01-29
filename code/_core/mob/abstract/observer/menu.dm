/mob/abstract/observer/menu

	spawning_buttons = list(
		/obj/hud/button/menu/title,
		/obj/hud/button/menu/selection/character_new,
		/obj/hud/button/menu/selection/character_load,
		/obj/hud/button/menu/selection/join_antagonist,
		/obj/hud/button/menu/selection/observe,
		/obj/hud/button/menu/selection/macros
	)

	alpha = 0

	anchored = 2

	var/current_lobby_position = 1
	var/next_lobby_cycle = 10 SECONDS

	invisibility = INVISIBILITY_ABSTRACT

/mob/abstract/observer/menu/do_say(text_to_say, should_sanitize = TRUE, talk_type_to_use = TEXT_TALK,talk_range=TALK_RANGE,language_to_use=null)
	return FALSE


/mob/abstract/observer/menu/New(desired_loc,client/C)

	. = ..()

	if(world_state < STATE_RUNNING)
		force_move(null)

/mob/abstract/observer/menu/think()

	. = ..()

	if(world_state >= STATE_RUNNING)
		var/positions = length(lobby_positions)

		if(positions)
			next_lobby_cycle -= 1 //This runs every decisecond.
			if(next_lobby_cycle <= 0)
				current_lobby_position++
				if(current_lobby_position >= positions)
					current_lobby_position = 1
				force_move(get_turf(lobby_positions[current_lobby_position]))
				next_lobby_cycle = initial(next_lobby_cycle)

/mob/abstract/observer/menu/PostInitialize()
	. = ..()
	START_THINKING(src)

/mob/abstract/observer/menu/PreDestroy()
	. = ..()
	STOP_THINKING(src)
