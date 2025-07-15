extends Node2D

var bullet_scene : PackedScene = preload("res://Scenes/bullet.tscn")

@export var shoot_rate : float = 0.5
var last_shoot_time : float

func _process(delta: float) -> void:
	if Time.get_unix_time_from_system() - last_shoot_time > shoot_rate:
		_shoot()

func _shoot():
	last_shoot_time = Time.get_unix_time_from_system()
	var bullet = bullet_scene.instantiate()
	self.add_child(bullet)
	bullet.global_position = $"Bullet Spawner".global_position
	bullet.move_dir = Vector2(1,0)
	print("bullet spawned")
