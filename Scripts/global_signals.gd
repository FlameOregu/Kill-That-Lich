extends Node
signal player_position(location: Vector2)
signal dirbullet_targ(location : Vector2)
signal battlestats(sanitynew, maxsanitynew, mananew, maxmananew)
var continued : bool
var maxsanity = 100
var maxmana = 100
var sanity = maxsanity
var mana = maxmana
var char_pos
var save_path = "user://klc_savefile.save"

func _ready():
	self.connect("battlestats", Callable(self, "_setstats"))

func _setstats(sanitynew, maxsanitynew, mananew, maxmananew):
	maxsanity = maxsanitynew
	sanity = sanitynew
	mana = mananew
	maxmana = maxmananew

func _save():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(var_to_str(char_pos))
	file.store_var(sanity)
	file.store_var(mana)
	file.store_var(maxsanity)
	file.store_var(maxmana)

func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		char_pos = str_to_var(file.get_var(true))
		sanity = file.get_var(true)
		mana = file.get_var(true)
		maxmana = file.get_var(true)
		maxsanity = file.get_var(true)
