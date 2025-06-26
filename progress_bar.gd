extends TextureProgressBar
@export var battlecharacter: Player

func _on_character_health_changed():
	value = battlecharacter.currenthealth / battlecharacter.maxhealth * 100
