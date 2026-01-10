extends CharacterBody2D
class_name Player
@export var basespeed = 350
var speed = basespeed
var direction:Vector2
var maxhealth
var maxmana
var currentmana
var currenthealth
var invincible = false
var infight : bool
var fighting = false
signal manachanged(currentmana, battlemaxmana)
signal on_character_moving(is_moving:bool)
signal healthChanged

func _ready():
	GlobalSignals.character = self
	maxhealth = GlobalSignals.maxsanity
	maxmana = GlobalSignals.maxmana
	currenthealth = GlobalSignals.sanity
	currentmana = GlobalSignals.mana

func _process(_delta):
	direction = Input.get_vector("left","right","up","down")
	if !direction.is_zero_approx():
		on_character_moving.emit(true)
	elif direction.is_zero_approx():
		on_character_moving.emit(false)

func _physics_process(_delta):
	velocity = direction * speed
	move_and_slide()
	GlobalSignals.emit_signal("player_position", global_position)

func _on_hurtbox_area_entered(area):
	if $Parrying.parry == true:
		$Parrying.parrycd = false
	if area.name == "hitbox" and invincible == false:
		_gethurt()

func _gethurt():
	_on_healthchange(10)
	$"Player SFX".stream = preload("res://Assets/SFX/hit 6.mp3")
	$"Player SFX".play()
	invincible = true
	$"Character Sprite".self_modulate.a = 0.5
	await get_tree().create_timer(0.55).timeout
	invincible = false
	$"Character Sprite".self_modulate.a = 255

func _on_endfight() -> void:
	invincible = true
	fighting = false
	infight = false

func _on_engage() -> void:
	$Parrying.parrycd = false
	$Parrying.parry = false
	invincible = false
	infight = true
	global_position = Vector2(560, 440)

func _on_fight() -> void:
	fighting = true

func _on_manachange(cost: int) -> void:
	currentmana -= cost
	manachanged.emit(currentmana, maxmana)

func _on_healthchange(damage : int):
	currenthealth -= damage
	healthChanged.emit()

func _on_endbattle() -> void:
	GlobalSignals.emit_signal("battlestats", currenthealth, maxhealth, currentmana, maxmana)
