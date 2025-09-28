extends TextureProgressBar
@export var battlecharacter: Player

func _on_character_health_changed():
	value = battlecharacter.currenthealth

func _ready():
	value = GlobalSignals.sanity
	max_value = GlobalSignals.maxsanity

func _setstats(currenthealth, maxhealth):
	value = battlecharacter.currenthealth
	max_value = battlecharacter.maxhealth
