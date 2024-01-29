/ai/boss/goblin_king
	var/mob/living/simple/goblin_king/owner_as_goblin_king
	var/last_goblin_spawn = 0
	var/last_totem_spawn = 0
	var/last_screech = 0

/ai/boss/goblin_king/New(desired_loc,mob/living/desired_owner)
	owner_as_goblin_king = desired_owner
	return ..()

/ai/boss/goblin_king/Destroy()
	owner_as_goblin_king = null
	return ..()

/ai/boss/goblin_king/on_damage_received(atom/atom_damaged,atom/attacker,atom/weapon,damagetype/DT,list/damage_table,damage_amount,critical_hit_multiplier,stealthy=FALSE)
	. = ..()
	if(owner && !owner.dead && objective_attack)
		var/choose_attack = rand(1,3)
		var/is_angry = owner_as_goblin_king.health.health_current <= owner_as_goblin_king.health.health_max/2
		var/cooldown = is_angry ? 15 : 30
		switch(choose_attack)
			if(1)
				if(last_goblin_spawn <= world.time)
					owner_as_goblin_king.summon_goblins(is_angry)
					last_goblin_spawn = world.time + cooldown SECONDS
			if(2)
				if(last_totem_spawn <= world.time)
					owner_as_goblin_king.summon_totems(is_angry)
					last_totem_spawn = world.time + cooldown SECONDS
			if(3)
				if(last_screech <= world.time)
					owner_as_goblin_king.screech(is_angry)
					last_screech = world.time + (cooldown * 2) SECONDS
