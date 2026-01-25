extends Node2D
var bultarg : Vector2
var trackbullet_scene : PackedScene = preload("res://Scenes/trackbullet.tscn")
var dirbullet_scene : PackedScene = preload("res://Scenes/dirbullet.tscn")
var wavebullet_scene : PackedScene = preload("res://Scenes/wavebullet.tscn")
var shootheight : int
var maxhp = 500
var currenthp = maxhp
var attacknum = 1
signal endfight #ends the attack
signal endbattle
signal health_changed(currenthp, maxhp)
@export var battlecharacter: Player

func _ready():
	GlobalSignals.enemy = self

func _trackshoot():
	var trackbullet = trackbullet_scene.instantiate()
	self.add_child(trackbullet)
	trackbullet.global_position = $"Bullet Spawner".global_position
	$"Bullet SFX".stream = preload("res://Assets/SFX/hopefully finished shot.mp3")
	$"Bullet SFX".play()

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
	$"Bullet SFX".stream = preload("res://Assets/SFX/big shot.mp3")
	$"Bullet SFX".play()
	GlobalSignals.emit_signal("dirbullet_targ", bultarg)

func _wavebullet(shootheight):
	var wavebullet = wavebullet_scene.instantiate()
	self.add_child(wavebullet)
	if shootheight == 1:
		wavebullet.global_position = ($"Bullet Spawner".global_position + Vector2(300,125))
		wavebullet.wave_radius = 400
		wavebullet.wave_speed_mult = 1.0

	elif shootheight == 2:
		wavebullet.global_position = ($"Bullet Spawner".global_position + Vector2(300,80))
		wavebullet.wave_radius = 200
		wavebullet.wave_speed_mult = 1.5

	elif shootheight == 3:
		wavebullet.global_position = ($"Bullet Spawner".global_position + Vector2(300,160))
		wavebullet.wave_radius = 100
		wavebullet.wave_speed_mult = 2.0

func _attack1() -> void:
	for i in range(20):
		_trackshoot()
		await get_tree().create_timer(0.65).timeout
	endfight.emit()

func _attack2() -> void: #bigshot direction
	for i in range(10):
		_dirshoot(1)
		await get_tree().create_timer(0.45).timeout
		_dirshoot(2)
		await get_tree().create_timer(0.45).timeout
		_dirshoot(3)
		await get_tree().create_timer(0.45).timeout
		_dirshoot(2)
		await get_tree().create_timer(0.45).timeout
	endfight.emit()

func _attack3():
	for i in range(10):
		_wavebullet(1)
		_trackshoot()
		await get_tree().create_timer(0.7).timeout
		_wavebullet(1)
		await get_tree().create_timer(0.7).timeout
	await get_tree().create_timer(2).timeout
	
	for i in range(5):
		_wavebullet(2)
		_trackshoot()
		await get_tree().create_timer(0.7).timeout
		_wavebullet(1)
		await get_tree().create_timer(0.7).timeout
		_wavebullet(2)
		await get_tree().create_timer(0.7).timeout
	await get_tree().create_timer(2).timeout

	for i in range(10):
		_wavebullet(3)
		_trackshoot()
		await get_tree().create_timer(0.7).timeout
		_wavebullet(2)
		await get_tree().create_timer(0.7).timeout
		_wavebullet(1)
		await get_tree().create_timer(0.7).timeout
	endfight.emit()

func _takedamage(damage):
	if (currenthp - damage) <= 0:
		_endbattle()
	currenthp -= damage
	health_changed.emit(currenthp, maxhp)

func _on_engage() -> void:
	if attacknum == 1:
		_attack1()
	elif attacknum == 2:
		_attack2()
	elif attacknum == 3:
		_attack3()
	attacknum += 1

func _endbattle(): #full battle is over, either lost or won
	endbattle.emit()
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")
