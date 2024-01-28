/**
 * The absolute base class for everything
 *
 * A datum instantiated has no physical world prescence, use an atom if you want something
 * that actually lives in the world
 *
 * Be very mindful about adding variables to this class, they are inherited by every single
 * thing in the entire game, and so you can easily cause memory usage to rise a lot with careless
 * use of variables at this level
 */
/datum/
	/**
	  * Tick count time when this object was destroyed.
	  *
	  * If this is non zero then the object has been garbage collected and is awaiting either
	  * a hard del by the GC subsystme, or to be autocollected (if it has no references)
	  */
	var/gc_destroyed

	/// Open uis owned by this datum
	/// Lazy, since this case is semi rare
	var/list/open_uis

	/// Active timers with this datum as the target
	var/list/_active_timers
	/// Status traits attached to this datum. associative list of the form: list(trait name (string) = list(source1, source2, source3,...))
	var/list/_status_traits

	/**
	  * Components attached to this datum
	  *
	  * Lazy associated list in the structure of `type -> component/list of components`
	  */
	var/list/_datum_components
	/**
	  * Any datum registered to receive signals from this datum is in this list
	  *
	  * Lazy associated list in the structure of `signal -> registree/list of registrees`
	  */
	var/list/_listen_lookup
	/// Lazy associated list in the structure of `target -> list(signal -> proctype)` that are run when the datum receives that signal
	var/list/list/_signal_procs

	/// Datum level flags
	var/datum_flags = NONE

	var/qdel_warning = 0
	var/qdel_warning_time = FALSE
	var/qdeleting = FALSE
	var/queue_delete_immune = FALSE
	var/list/hooks

/datum/proc/get_examine_list(var/mob/examiner)
	return list(div("examine_title","[src]"),div("examine_description","[src.type]"))

/datum/proc/get_examine_details_list(var/mob/examiner)
	return list()

/datum/proc/delete()
	qdel(src)
	return TRUE

//Credit to Kachnov for this garbage collection code.
/datum/proc/Destroy()
	tag = null // required to GC
	hooks?.Cut()
	return TRUE

/datum/proc/PreDestroy()
	return TRUE

/datum/proc/PostDestroy()
	return TRUE

/datum/proc/get_debug_name()
	return "[src.type]"

/datum/proc/get_log_name()
	return "[src.type]"
