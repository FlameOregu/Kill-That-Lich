extends Label
@export var battlecharacter: Player
var currenthealth : int
var maxhealth : int

func _ready():
	maxhealth = GlobalSignals.maxsanity
	currenthealth = GlobalSignals.sanity
	self.text = str("Sanity: ", str(currenthealth) + "/" + str(maxhealth))

func _on_character_health_changed():
	self.text = str("Sanity: ", str(int(battlecharacter.currenthealth)) + "/" + str(int(battlecharacter.maxhealth)))
