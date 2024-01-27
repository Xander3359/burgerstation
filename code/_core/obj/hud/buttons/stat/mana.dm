/obj/hud/button/stat/mana
	name = "mana"
	desc = "Mana for your soul"
	id = "mana"

	icon = 'icons/hud/mana.dmi'
	icon_state = "mana"

	screen_loc = "CENTER,CENTER+1"

	user_colors = FALSE

	appearance_flags = NO_CLIENT_COLOR | PIXEL_SCALE | LONG_GLIDE | TILE_BOUND | KEEP_TOGETHER

	mouse_opacity = 0

	alpha = 0

/obj/hud/button/stat/mana/update_underlays()
	. = ..()
	var/image/I = new/image(initial(icon),"mana_outline")
	I.appearance_flags = src.appearance_flags | RESET_COLOR | RESET_ALPHA
	add_underlay(I)

/obj/hud/button/stat/mana/update_owner(var/mob/desired_owner)
	color = "#000000"
	. = ..()

/obj/hud/button/stat/mana/update()

	if(!is_living(owner))
		return FALSE

	var/mob/living/L = owner

	var/good_color = "#00FF00"
	var/good_color_outline = "#0000FF"

	var/bad_color = "#FF0000"
	var/bad_color_outline = "#FFFFFF"

	if(L && L.client)
		var/color_scheme = L.client.settings.loaded_data["hud_colors"]
		good_color = color_scheme[3]
		bad_color = color_scheme[6]
		good_color_outline = color_scheme[2]
		bad_color_outline = color_scheme[5]

	var/mana_percent = L.health.mana_current/L.health.mana_max
	var/stamina_percent = L.health.stamina_current/L.health.stamina_max

	var/list/color_mod = list(
		blend_colors(bad_color,good_color,mana_percent),
		blend_colors(bad_color_outline,good_color_outline,mana_percent),
		"#000000"
	)

	if(color == "#000000")
		color=color_mod
	else
		var/matrix/M = get_base_transform()
		var/desired_alpha = 180
		if(mana_percent >= 1)
			desired_alpha = 0
		if(stamina_percent < 1)
			M.Translate(16,0)
		animate(src,color=color_mod,time=TICKS2DS(LIFE_TICK_FAST))
		animate(src,alpha=desired_alpha,transform=M,time=1 SECONDS)

	icon_state = "mana_[clamp(CEILING(mana_percent*19,1),0,19)]"


	. = ..()

/obj/hud/button/stat/mana/get_examine_list(var/mob/examiner)
	return examiner.get_examine_list(examiner)
