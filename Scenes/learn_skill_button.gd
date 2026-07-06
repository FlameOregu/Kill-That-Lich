extends Button
@export var buttonbeep : Node2D

func _on_focus_entered() -> void:
	buttonbeep.play()
