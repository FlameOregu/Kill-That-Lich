extends ProgressBar
@export var battlecharacter : Player

func _on_character_manachanged(currentmana: Variant, maxmana: Variant) -> void:
	value = currentmana / maxmana * 100

func _ready():
	max_value = GlobalSignals.maxmana
	value = GlobalSignals.mana
