extends CharacterBody2D
signal start_dialogue
signal show_icon
signal hide_icon
var intext : bool
var textboxgb
var textbox_scene : PackedScene = preload("res://Scenes/textbox.tscn")

func _on_start_dialogue() -> void:
	var textbox = textbox_scene.instantiate()
	textboxgb = textbox
	$"../Text Layer".add_child(textbox)
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

func _ready():
	$Interaction.connect("area_entered", Callable($"../Character", "_on_interaction_area_entered"))
	$Interaction.connect("area_exited", Callable($"../Character", "_on_interaction_area_exited"))
	_on_hide_icon()

func _on_show_icon() -> void:
	$"Interact Icon".visible = true

func _on_hide_icon() -> void:
	$"Interact Icon".visible = false
