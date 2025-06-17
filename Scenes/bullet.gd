extends Area2D

var velocity: Vector2 = Vector2()
var duration = 20

func _process(delta: float) -> void:
	position += velocity * delta
	duration -= delta
	if duration <= 0:
		queue_free()
		

func _on_hitbox_area_entered(area):
	if area.name == "hurtbox":
		queue_free()
