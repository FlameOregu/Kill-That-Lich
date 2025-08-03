extends Node2D
var bultarg : Vector2
var trackbullet_scene : PackedScene = preload("res://Scenes/trackbullet.tscn")
var dirbullet_scene : PackedScene = preload("res://Scenes/dirbullet.tscn")
signal atk1fin
@export var battlecharacter: Player

func _attack1() -> void:
	for i in range(20):
		_trackshoot()
		await get_tree().create_timer(0.65).timeout
	atk1fin.emit()

func _attack2() -> void:
	for i in range(20):
		_dirshoot()
		await get_tree().create_timer(0.8).timeout

func _dirshoot() -> void:
	var dirbullet = dirbullet_scene.instantiate()
	self.add_child(dirbullet)
	dirbullet.global_position = ($"Bullet Spawner".global_position) + Vector2(300, 125)
	bultarg = dirbullet.global_position + Vector2(-600,0)
	GlobalSignals.emit_signal("dirbullet_targ", bultarg)

func _ready() -> void:
	_attack1()

func _trackshoot():
	var trackbullet = trackbullet_scene.instantiate()
	self.add_child(trackbullet)
	trackbullet.global_position = $"Bullet Spawner".global_position
