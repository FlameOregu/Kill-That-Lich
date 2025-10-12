extends Node2D
var label = Node
var saving = false
signal start_dialogue
signal show_icon
signal hide_icon
var intext : bool
var textboxgb
var textbox_scene : PackedScene = preload("res://Scenes/textbox.tscn")

func _ready():
	$Area2D.connect("area_entered", Callable($"../Character","_on_interaction_area_entered"))
	$Area2D.connect("area_exited", Callable($"../Character","_on_interaction_area_exited"))
	_on_hide_icon()

func _on_show_icon() -> void:
	$"Interact Icon".visible = true

func _on_hide_icon() -> void:
	$"Interact Icon".visible = false

func _on_start_dialogue() -> void:
	var textbox = textbox_scene.instantiate()
	textboxgb = textbox
	$"../Text Layer".add_child(textbox)
	label = textbox.get_node("Text")
	label.text = "Press Z to Save your Game\nPress X to Cancel"
	textbox.visible = true
	$"../Character".inmenu = true
	await get_tree().create_timer(0.2).timeout
	intext = true

func _cancel():
	textboxgb.queue_free()
	intext = false
	$"../Character".inmenu = false
	$"../Character".speed = 100
	saving = false

func _input(event):
	if Input.is_action_just_pressed("cancel") and intext == true:
		_cancel()
	elif Input.is_action_just_pressed("interact") and intext == true and saving == false:
		_save()
	elif Input.is_action_just_pressed("interact") and intext == true:
		_cancel()

func _save():
	saving = true
	GlobalSignals.char_pos = $"../Character".position
	GlobalSignals._save()
	label.text = "Data Saved Successfully."
	await get_tree().create_timer(0.4).timeout
