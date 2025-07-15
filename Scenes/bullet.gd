extends Node2D

var velocity: float = 50
var duration = 20

var move_dir: Vector2

func _process(delta):
	translate(move_dir * velocity * delta)
	duration -= delta
	if duration < 0:
		queue_free()
		print("deleted")

func _on_area_entered(area: Area2D) -> void:
	if area.name == "hurtbox":
		queue_free()
		print("deleted")
