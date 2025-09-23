extends ProgressBar

func _ready():
	max_value = $"..".maxhp
	value = $"..".maxhp

func _on_health_changed(currenthp: Variant, maxhp: Variant) -> void:
	value = currenthp 
