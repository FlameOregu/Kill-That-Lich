extends ProgressBar
@export var Enemy : Node

func _ready():
	max_value = Enemy.maxhp
	value = Enemy.maxhp

func _on_health_changed(currenthp: Variant, maxhp: Variant) -> void:
	value = currenthp 
