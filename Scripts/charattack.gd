extends Node2D
var arrow_string : String
var current_atk : String
var last_atk : String
var damage = 0.0
var atk_repeat = 0
var skatecombo : Array
var combo_active : bool
var stylemult : float = 1
var basedmg : int
var key_to_arrow = {
	"up": "↑",
	"down": "↓",
	"left": "←",
	"right": "→"
	}
var ranks = {
	"F": 1,
	"E": 1.2,
	"D": 1.4,
	"C": 1.7,
	"B": 2.0,
	"A": 2.5,
	"S": 3.0
}
signal enemyhit(damage: int)
signal style
signal combo(combo: String) #sends combo text, and plays combo sound

func _combostart():
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
	$"../../Combo Arrows".text = arrow_string

func _ollie():
	basedmg = 20
	print("ollie")
	current_atk = "ollie"
	if current_atk == last_atk:
		atk_repeat += 1
	else:
		atk_repeat = 0
	damage = basedmg * max(1.0 -(atk_repeat * 0.2), 0.1 ) * stylemult
	enemyhit.emit(damage)
	combo.emit(str("Ollie!\n" + str(damage) + " Dmg"))
	style.emit(damage)
	last_atk = "ollie"

func _kickflip():
	basedmg = 40
	print("kickflip")
	current_atk = "kickflip"
	if current_atk == last_atk:
		atk_repeat += 1
	else:
		atk_repeat = 0
	damage = basedmg * max(1.0 -(atk_repeat * 0.2), 0.1 ) * stylemult
	enemyhit.emit(damage)
	combo.emit(str("Kickflip!\n" + str(damage) + " Dmg"))
	style.emit(damage)
	last_atk = "kickflip"

func _input(event):
	if Input.is_action_just_pressed("interact") == true: #startcombo
		$"..".speed = 180
		combo_active = true
		skatecombo.clear()
		
	if combo_active == true:
		_combostart()
	
	if Input.is_action_just_released("interact") == true: #endcombo/attack
		combo_active = false
		arrow_string = ""
		if skatecombo == ["down", "up"]: #ollie
			_ollie()
	
		elif skatecombo == ["up", "down", "right", "left"]: #kickflip
			_kickflip()
		$"..".speed = $"..".basespeed


func _on_style(rank) -> void:
	stylemult = ranks[rank]
