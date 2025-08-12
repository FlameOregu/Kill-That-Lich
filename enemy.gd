extends Node2D
var bultarg : Vector2
var trackbullet_scene : PackedScene = preload("res://Scenes/trackbullet.tscn")
var dirbullet_scene : PackedScene = preload("res://Scenes/dirbullet.tscn")
var shootheight : int
var enemyhealth = 200
signal atk1fin
@export var battlecharacter: Player


func _attack1() -> void:
	for i in range(20):
		_trackshoot()
		$"Bullet SFX".stream = preload("res://Assets/hopefully finished shot.mp3")
		$"Bullet SFX".play()
		await get_tree().create_timer(0.65).timeout
	atk1fin.emit()

func _attack2() -> void:
	for i in range(10):
		_dirshoot(1)
		await get_tree().create_timer(0.45).timeout
		_dirshoot(2)
		await get_tree().create_timer(0.45).timeout
		_dirshoot(3)
		await get_tree().create_timer(0.45).timeout
		_dirshoot(2)
		await get_tree().create_timer(0.45).timeout

func _dirshoot(shootheight) -> void:
	var dirbullet = dirbullet_scene.instantiate()
	self.add_child(dirbullet)
	if shootheight == 1:
		dirbullet.global_position = ($"Bullet Spawner".global_position) + Vector2(300, 50) #top
	elif shootheight == 2:
		dirbullet.global_position = ($"Bullet Spawner".global_position) + Vector2(300, 125) #middle
	elif shootheight == 3:
		dirbullet.global_position = ($"Bullet Spawner".global_position) + Vector2(300, 200) #bottom
	bultarg = dirbullet.global_position + Vector2(-600,0)
	GlobalSignals.emit_signal("dirbullet_targ", bultarg)

func _ready() -> void:
	_attack1()

func _trackshoot():
	var trackbullet = trackbullet_scene.instantiate()
	self.add_child(trackbullet)
	trackbullet.global_position = $"Bullet Spawner".global_position

func _takedamage(damage):
	enemyhealth -= damage
	if enemyhealth == 0:
		print("you won!")
