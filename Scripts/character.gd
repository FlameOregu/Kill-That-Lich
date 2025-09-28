extends CharacterBody2D
@export var speed = 100
var direction:Vector2
var interactrad : bool
var currentnpc : Node2D
var inmenu = false
signal on_character_moving(is_moving:bool)

func _process(_delta):
	direction = Input.get_vector("left","right","up","down") 
	if !direction.is_zero_approx():
		on_character_moving.emit(true)
	elif direction.is_zero_approx():
		on_character_moving.emit(false)

func _physics_process(_delta):
	velocity = direction * speed
	move_and_slide()

func _input(event):
	if Input.is_action_just_pressed("interact") and interactrad == true and inmenu == false: #checks if in menu and in interaction radius
		var npcs : Array = get_tree().get_nodes_in_group("NPC") #grabs all nodes in the NPC group and puts in array
		var shortest_distance : float = global_position.distance_to(npcs[0].global_position)
		currentnpc = npcs[0]
		for i in npcs:
			var currentdist : float = global_position.distance_to(i.global_position)
			if currentdist < shortest_distance:
				currentnpc = i
				shortest_distance = currentdist
		speed = 0
		currentnpc.emit_signal("start_dialogue") #tells the npc to go start the damn dialogue

func _on_interaction_area_entered(area: Area2D) -> void:
	interactrad = true

func _on_interaction_area_exited(area: Area2D) -> void:
	interactrad = false
