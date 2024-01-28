SUBSYSTEM_DEF(gamemode)
	name = "Gamemode Subsystem"
	desc = "Stores all the known gamemodes and triggers a vote for the gamemode when the game starts."
	priority = SS_ORDER_LAST
	wait = SECONDS_TO_TICKS(1)


	var/list/all_gamemodes = list()
	var/gamemode/active_gamemode

	var/list/tracked_rogues = list()

	var/list/tracked_bosses = list()

/datum/controller/subsystem/gamemode/unclog(mob/caller)

	if(active_gamemode)
		var/gamemode/G = active_gamemode.type
		set_active_gamemode(G,"unclog")

	. = ..()

/datum/controller/subsystem/gamemode/proc/set_active_gamemode(gamemode/desired_gamemode, source)
	QDEL_NULL(active_gamemode)
	active_gamemode = new desired_gamemode
	log_debug("Setting gamemode to: [active_gamemode.name]... Source: [source].")

	if(source == "voting on_result")
		var/displayed_address = world.url ? world.url : "byond://[world.internet_address]:[world.port]"
		SSdiscord.send_message("Starting new round (ID: [SSlogging.round_id]) on [SSdmm_suite.map_name] with gamemode [active_gamemode.name]. Join at <[displayed_address]>! <@&695106439911571516>")

	return TRUE

/datum/controller/subsystem/gamemode/Initialize()

	for(var/k in subtypesof(/gamemode/))
		var/gamemode/G = k
		if(initial(G.hidden))
			continue
		all_gamemodes += G

	log_subsystem(name,"Stored [length(all_gamemodes)] gamemodes.")

	return ..()

/datum/controller/subsystem/gamemode/PostInitialize()
	. = ..()
	set_active_gamemode(/gamemode/lobby,"Gamemode PostInitialize()")


/datum/controller/subsystem/gamemode/on_life()
	if(active_gamemode) active_gamemode.on_life()
	return TRUE
