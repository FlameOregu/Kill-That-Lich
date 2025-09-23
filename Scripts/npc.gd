extends CharacterBody2D
signal start_dialogue
var intext : bool
var textboxgb
var textbox_scene : PackedScene = preload("res://Scenes/textbox.tscn")

func _on_start_dialogue() -> void:
	var textbox = textbox_scene.instantiate()
	textboxgb = textbox
	$"../Text Layer".add_child(textbox)
	var viewport_size = get_viewport_rect().size
	var size = textbox.get_size()
	textbox.position.x = viewport_size.x / 2 - size.x / 2
	textbox.position.y = viewport_size.y - size.y - 10
	var label = textbox.get_node("Text")
	if self == $"../NPC Test2":
		label.text = "what do you want nerd"
	else:
		label.text = "sup"
	textbox.visible = true
	$"../Character".inmenu = true
	await get_tree().create_timer(0.2).timeout
	intext = true

func _input(event):
	if (Input.is_action_just_pressed("interact") or Input.is_action_just_pressed("cancel")) and intext == true:
		textboxgb.queue_free()
		intext = false
		$"../Character".inmenu = false
		$"../Character".speed = 100
