extends CharacterBody2D
class_name Player
@export var basespeed = 350
var speed = basespeed
var skatecombo : Array
var combo_active : bool
var direction:Vector2
var maxhealth = 100.0
var maxmana = 100.0
var currentmana = maxmana
var currenthealth: float = maxhealth
var arrow_string : String
var current_atk : String
var last_atk : String
var damage = 0.0
var atk_repeat = 0
var invincible = false
var infight : bool
signal manachanged(currentmana, maxmana)
signal combo(combo: String)
signal on_character_moving(is_moving:bool)
signal healthChanged
signal enemyhit(damage: int)
var fighting = false #ONLY FOR FIGHTING LIKE SKATEBOARD
var key_to_arrow = {
	"up": "↑",
	"down": "↓",
	"left": "←",
	"right": "→"
	}

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
	if area.name == "hitbox" and invincible == false:
		_on_healthchange(10)
		$"Player SFX".stream = preload("res://Assets/SFX/hit 6.mp3")
		$"Player SFX".play()
		invincible = true
		$"Character Sprite".self_modulate.a = 0.5
		await get_tree().create_timer(0.55).timeout
		invincible = false
		$"Character Sprite".self_modulate.a = 255

func _input(event): #SKATEBOARD!!!!
	if fighting == true:
		if Input.is_action_just_pressed("interact") == true:
			speed = 180
			combo_active = true
			skatecombo.clear()
			
		if combo_active == true:
			if Input.is_action_just_pressed("left") == true:
				skatecombo.append("left")
				arrow_string += key_to_arrow["left"]
			elif Input.is_action_just_pressed("right") == true:
				skatecombo.append("right")
				arrow_string += key_to_arrow["right"]
			elif Input.is_action_just_pressed("down") == true:
				skatecombo.append("down")
				arrow_string += key_to_arrow["down"]
			elif Input.is_action_just_pressed("up") == true:
				skatecombo.append("up")
				arrow_string += key_to_arrow["up"]
			
			$"../Combo Arrows".text = arrow_string
			
		if Input.is_action_just_released("interact") == true:
			combo_active = false
			arrow_string = ""
			if skatecombo == ["down", "up"]: #ollie
				print("ollie")
				current_atk = "ollie"
				if current_atk == last_atk:
					atk_repeat += 1
				else:
					atk_repeat = 0
				damage = 20 * max(1.0 -(atk_repeat * 0.2), 0.1 )
				enemyhit.emit(damage)
				combo.emit(str("Ollie!\n" + str(damage) + " Dmg"))
				$"Player SFX".stream = preload("res://Assets/combo 4.mp3")
				$"Player SFX".play()
				last_atk = "ollie"
				
			elif skatecombo == ["up", "down", "right", "left"]: #kickflip
				print("kickflip")
				current_atk = "kickflip"
				if current_atk == last_atk:
					atk_repeat += 1
				else:
					atk_repeat = 0
				damage = 40 * max(1.0 -(atk_repeat * 0.2), 0.1 )
				enemyhit.emit(damage)
				combo.emit(str("Kickflip!\n" + str(damage) + " Dmg"))
				$"Player SFX".stream = preload("res://Assets/SFX/combo 4.mp3")
				$"Player SFX".play()
				last_atk = "kickflip"
			speed = basespeed
	else:
		if Input.is_action_just_pressed("interact"):
			speed = 180
		elif Input.is_action_just_released("interact"):
			speed = basespeed

func _on_endfight() -> void:
	invincible = true
	fighting = false
	infight = false

func _on_engage() -> void:
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
