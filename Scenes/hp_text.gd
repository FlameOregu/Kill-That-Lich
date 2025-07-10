extends Label
@export var battlecharacter: Player

func _ready():
	self.text = str("Sanity: ", str(int(battlecharacter.currenthealth)) + "/" + str(int(battlecharacter.maxhealth)))

func _on_character_health_changed():
	self.text = str("Sanity: ", str(int(battlecharacter.currenthealth)) + "/" + str(int(battlecharacter.maxhealth)))
