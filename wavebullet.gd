extends Node2D
var speed = 120
var angle = 180
var wave_speed_mult = 1.0
var wave_radius = 400
var wave_length_seconds = 2.0
var velocity: Vector2 
var bullet_position: Vector2 
var time_flying = 0
var duration = 5

func _ready():
	self.visible = false
	bullet_position = position
	velocity = Vector2(speed, 0).rotated(deg_to_rad(angle))

func _process(delta):
	visible = true
	time_flying += delta
	bullet_position += velocity * delta
	var cycle_time = wave_length_seconds / wave_speed_mult
	var wave_phase = (time_flying / cycle_time) * TAU
	var wave_offset = cos(wave_phase) * wave_radius
	var wave_vector = velocity.normalized().orthogonal() * wave_offset
	var move_vector = (velocity * delta) + wave_vector * delta
	translate(move_vector)
	
	if move_vector.length() > 0.001:
		rotation = move_vector.angle()
	
	duration -= delta
	if duration < 0:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.name == "hurtbox":
		queue_free()
