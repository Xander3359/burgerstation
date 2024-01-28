#define GLOBAL_PROC	"some_magic_bullshit"
/// A shorthand for the callback datum, [documented here](datum/callback.html)
#define CALLBACK new /datum/callback

//#define CALLBACK(desired_id,desired_time,desired_object,desired_proc,arguments...) SScallback.add_callback(desired_id,desired_time,desired_object,nameof(desired_proc),arguments)
#define CALLBACK_EXISTS(desired_id) SScallback.all_callbacks[desired_id]
#define CALLBACK_REMOVE(desired_id) SScallback.remove_callback(desired_id)
