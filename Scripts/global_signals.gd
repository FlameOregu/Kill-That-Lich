extends Node
signal player_position(location: Vector2)
signal dirbullet_targ(location : Vector2)
signal battlestats(sanitynew, maxsanitynew, mananew, maxmananew)
var maxsanity = 100
var maxmana = 100
var sanity = maxsanity
var mana = maxmana


func _ready():
	self.connect("battlestats", Callable(self, "_setstats"))

func _setstats(sanitynew, maxsanitynew, mananew, maxmananew):
	maxsanity = maxsanitynew
	sanity = sanitynew
	mana = mananew
	maxmana = maxmananew
