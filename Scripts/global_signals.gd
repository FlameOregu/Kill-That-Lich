extends Node
signal player_position(location: Vector2)
signal dirbullet_targ(location : Vector2)
signal battlestats(sanitynew, maxsanitynew, mananew, maxmananew)
var continued : bool
var maxsanity = 100
var maxmana = 100
var sanity = maxsanity
var mana = maxmana
var battle = false
var char_pos
var base_action_points = 1
var flair : int = 1
var cool : int = 1
var nrg : int = 1
var aura : int = 1
var magics = ["res://Scenes/fireball.tscn"]
var poses = ["res://Scenes/rest_pose.tscn"]
var save_path = "user://klc_savefile.save"
var skillpoints = 1
var inventory = []
var enemy : Node = null
var character : Node = null
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
	file.store_var(var_to_str(sanity))
	file.store_var(var_to_str(mana))
	file.store_var(var_to_str(maxsanity))
	file.store_var(var_to_str(maxmana))
	file.store_var(var_to_str(inventory))
	file.store_var(var_to_str(poses))
	file.store_var(var_to_str(magics))
	file.store_var(var_to_str(skillpoints))
	file.store_var(var_to_str(base_action_points))
	file.store_var(var_to_str(flair))
	file.store_var(var_to_str(cool))
	file.store_var(var_to_str(nrg))
	file.store_var(var_to_str(aura))

func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		char_pos = str_to_var(file.get_var(true))
		sanity = str_to_var(file.get_var(true))
		mana = str_to_var(file.get_var(true))
		maxmana = str_to_var(file.get_var(true))
		maxsanity = str_to_var(file.get_var(true))
		inventory = str_to_var(file.get_var(true))
		poses = str_to_var(file.get_var(true))
		magics = str_to_var(file.get_var(true))
		skillpoints = str_to_var(file.get_var(true))
		base_action_points = str_to_var(file.get_var(true))
		flair = str_to_var(file.get_var(true))
		cool = str_to_var(file.get_var(true))
		nrg = str_to_var(file.get_var(true))
		aura = str_to_var(file.get_var(true))
