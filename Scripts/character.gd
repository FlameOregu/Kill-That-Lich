extends CharacterBody2D
@export var speed = 100
var direction:Vector2
var interactrad : bool
var inmenu = false
var interacters = 0
var distnpcs : Array
var closestnpc : Node2D
var lastnpc : Node2D
signal on_character_moving(is_moving:bool)

func _ready():
	if GlobalSignals.continued == true:
		position = GlobalSignals.char_pos
		GlobalSignals.continued = false

func _process(_delta):
	direction = Input.get_vector("left","right","up","down") 
	if !direction.is_zero_approx():
		on_character_moving.emit(true)
	elif direction.is_zero_approx():
		on_character_moving.emit(false)
	if interactrad == true:
		var npcs : Array = get_tree().get_nodes_in_group("NPC") #grabs all nodes in the NPC group and puts in array
		for i in len(npcs):
			var npc : Array
			npc.append(npcs[i])
			npc.append(0.0)
			npc[1] = global_position.distance_to(npcs[i].global_position)
			distnpcs.append(npc)
		distnpcs.sort()
		closestnpc = distnpcs[0][0]
		if lastnpc != closestnpc and lastnpc != null:
			lastnpc.emit_signal("hide_icon")
		closestnpc.emit_signal("show_icon")
		lastnpc = closestnpc
		distnpcs.clear()

func _physics_process(_delta):
	velocity = direction * speed
	move_and_slide()

func _input(event):
	if Input.is_action_just_pressed("interact") and interactrad == true and inmenu == false: #checks if in menu and in interaction radius
		speed = 0
		closestnpc.emit_signal("start_dialogue") #tells the npc to go start the damn dialogue
	elif Input.is_action_just_pressed("menu"):
		speed = 0
		

func _on_interaction_area_entered(area: Area2D) -> void:
	interactrad = true
	interacters += 1

func _on_interaction_area_exited(area: Area2D) -> void:
	interacters -= 1
	if interacters == 0:
		interactrad = false
		var npcs : Array = get_tree().get_nodes_in_group("NPC") #grabs all nodes in the NPC group and puts in array
		for i in npcs:
			i.emit_signal("hide_icon")
