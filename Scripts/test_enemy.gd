extends Node
var bultarg : Vector2
var trackbullet_scene : PackedScene = preload("res://Scenes/trackbullet.tscn")
var dirbullet_scene : PackedScene = preload("res://Scenes/dirbullet.tscn")
var wavebullet_scene : PackedScene = preload("res://Scenes/wavebullet.tscn")
var shootheight : int
var attacknum = 1
var enemy : Node
var BulletSpawner : Node
var BulletSFX : Node
signal endattack

func _ready():
	enemy = GlobalSignals.enemy
	BulletSFX = $"../Bullet SFX"
	BulletSpawner = $"../Bullet Spawner"
	enemy.attack.connect(_attack)
	endattack.connect(enemy._endfight)

func _attack():
	if attacknum == 1:
		await _attack1()
	elif attacknum == 2:
		await _attack2()
	elif attacknum == 3:
		await _attack3()
	attacknum += 1
	endattack.emit()

func _attack1() -> void:
	await get_tree().create_timer(0.35).timeout
	for i in range(20):
		_trackshoot()
		await get_tree().create_timer(0.65).timeout

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

func _trackshoot():
	var trackbullet = trackbullet_scene.instantiate()
	self.add_child(trackbullet)
	trackbullet.global_position = BulletSpawner.global_position
	BulletSFX.stream = preload("res://Assets/SFX/hopefully finished shot.mp3")
	BulletSFX.play()

func _dirshoot(shootheight) -> void:
	var dirbullet = dirbullet_scene.instantiate()
	self.add_child(dirbullet)
	if shootheight == 1:
		dirbullet.global_position = (BulletSpawner.global_position) + Vector2(300, 50) #top
	elif shootheight == 2:
		dirbullet.global_position = (BulletSpawner.global_position) + Vector2(300, 125) #middle
	elif shootheight == 3:
		dirbullet.global_position = (BulletSpawner.global_position) + Vector2(300, 200) #bottom
	bultarg = dirbullet.global_position + Vector2(-600,0)
	BulletSFX.stream = preload("res://Assets/SFX/big shot.mp3")
	BulletSFX.play()
	GlobalSignals.emit_signal("dirbullet_targ", bultarg)

func _wavebullet(shootheight):
	var wavebullet = wavebullet_scene.instantiate()
	self.add_child(wavebullet)
	if shootheight == 1:
		wavebullet.global_position = (BulletSpawner.global_position + Vector2(300,125))
		wavebullet.wave_radius = 400
		wavebullet.wave_speed_mult = 1.0

	elif shootheight == 2:
		wavebullet.global_position = (BulletSpawner.global_position + Vector2(300,80))
		wavebullet.wave_radius = 200
		wavebullet.wave_speed_mult = 1.5

	elif shootheight == 3:
		wavebullet.global_position = (BulletSpawner.global_position + Vector2(300,160))
		wavebullet.wave_radius = 100
		wavebullet.wave_speed_mult = 2.0
