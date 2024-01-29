

SUBSYSTEM_DEF(damagetype)
	name = "Damage Type Subsystem"
	desc = "Stores all the known damage types in a list."
	priority = SS_ORDER_CONFIG

	var/list/all_damage_types = list()

	var/list/all_damage_numbers = list()

	//tick_rate = DS2TICKS(1)

	//var/list/damage_to_process = list()

/*
/subsystem/damagetype/on_life()

	for(var/d_id in damage_to_process)
		try
			var/list/damage_list = damage_to_process[d_id]
			var/damagetype/DT = damage_list["damage_type"]
			DT.process_damage(damage_list["attacker"],damage_list["victim"],damage_list["weapon"],damage_list["hit_object"],damage_list["blamed"],damage_list["damage_multiplier"])
		catch(var/exception/e)
			log_error("Damage Subsystem Error: [e] on [e.file]:[e.line]!<br>[e.desc]")
		damage_to_process -= d_id

	return ..()
*/


/subsystem/damagetype/Initialize()

	for(var/A in subtypesof(/damagetype/))
		var/damagetype/D = new A
		SSdamagetype.all_damage_types[D.type] = D

	log_subsystem(name,"Initialized [length(SSdamagetype.all_damage_types)] damage types.")

	CREATE(/mob/abstract/melee_checker,locate(1,1,1))

	return ..()

/*
/subsystem/damagetype/proc/add_damage(atom/attacker,atom/victim,atom/weapon,atom/hit_object,atom/blamed,damage_multiplier=1,damagetype/DT)

	var/reference_id = "\ref[weapon]_\ref[hit_object]"

	if(damage_to_process[reference_id])
		damage_to_process[reference_id]["damage_multiplier"] += damage_multiplier
		return TRUE

	var/list/list_to_generate = list(
		"attacker" = attacker,
		"victim" = victim,
		"weapon"= weapon,
		"hit_object" = hit_object,
		"blamed" = blamed,
		"damage_multiplier" = damage_multiplier,
		"damage_type" = DT
	)

	damage_to_process[reference_id] = list_to_generate

	return TRUE
*/
