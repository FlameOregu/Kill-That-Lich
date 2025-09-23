extends Node2D
var save_path = "user://variable.save"
var location = Vector2()
var sanity : int
var mana : int
var label = Node
var saving = false
signal start_dialogue
signal grab_location
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
	label = textbox.get_node("Text")
	label.text = "Do you want to save your game?"
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
	grab_location.emit()
	GlobalStats.connect("char_location", Callable(self, "_location"))
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(location)
	file.store_var(sanity)
	file.store_var(mana)
	label.text = "Data Saved Successfully."
	await get_tree().create_timer(0.4).timeout

func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		location = file.get_var(location)
		sanity = file.get_var(sanity)
		mana = file.get_var(mana)

func _location(charpos):
	location = charpos
