extends CharacterBody2D
class_name Player
@export var basespeed = 350
var speed : int = basespeed
var direction:Vector2
var maxhealth
var maxmana
var currentmana
var currenthealth
var base_action_points = GlobalSignals.base_action_points
var action_points = base_action_points
var invincible = false
var infight : bool
var damage_mult : bool
var style_points
signal manachanged(currentmana, battlemaxmana)
signal on_character_moving(is_moving:bool)
signal healthChanged
signal parry #currently, just sends out parry sound signal
signal hurt #currently, just sends out hurt sound signal

func _ready():
	GlobalSignals.character = self
	_on_ap_change(0)
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
		parry.emit()
	if area.name == "hitbox" and invincible == false:
		_gethurt()

func _gethurt():
	_on_healthchange(10)
	if currenthealth <= 0:
		_deathscreen()
	else:
		hurt.emit()
		invincible = true
		$"Character Sprite".self_modulate.a = 0.5
		await get_tree().create_timer(0.55).timeout
		invincible = false
		$"Character Sprite".self_modulate.a = 255

func _on_endfight() -> void:
	action_points = base_action_points
	_on_ap_change(0)
	invincible = true
	infight = false

func _on_engage() -> void:#start the fight phase
	$Parrying.parrycd = false
	$Parrying.parry = false
	invincible = false
	infight = true
	global_position = Vector2(560, 440)

func _on_manachange(cost: int) -> void:
	currentmana -= cost
	manachanged.emit(currentmana, maxmana)

func _on_healthchange(damage : int):
	currenthealth -= damage
	healthChanged.emit()

func _on_ap_change(cost : int):
	action_points -= cost
	$"../../Action Points".text = "Action Points: " + str(action_points)

func _on_endbattle() -> void:
	GlobalSignals.emit_signal("battlestats", currenthealth, maxhealth, currentmana, maxmana)

func _deathscreen():
	get_tree().change_scene_to_file("res://Scenes/death.tscn")
