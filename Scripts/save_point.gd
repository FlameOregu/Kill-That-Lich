extends Node2D
var save_path = "user://klc_savefile.save"
var location = Vector2()
var currenthealth : int
var currentmana : int
var battlemaxmana : int
var maxhealth : int
var label = Node
var saving = false
signal start_dialogue
var intext : bool
var textboxgb
var textbox_scene : PackedScene = preload("res://Scenes/textbox.tscn")

func _ready():
	$Area2D.connect("area_entered", Callable($"../Character","_on_interaction_area_entered"))
	$Area2D.connect("area_exited", Callable($"../Character","_on_interaction_area_exited"))

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
		print("saving")
		_save()
	elif Input.is_action_just_pressed("interact") and intext == true:
		_cancel()

func _save():
	saving = true
	location = $"../Character".position
	maxhealth = GlobalSignals.maxsanity
	battlemaxmana = GlobalSignals.maxmana
	currenthealth = GlobalSignals.sanity
	currentmana = GlobalSignals.mana
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(location)
	file.store_var(currenthealth)
	file.store_var(currentmana)
	file.store_var(maxhealth)
	file.store_var(battlemaxmana)
	label.text = "Data Saved Successfully."
	await get_tree().create_timer(0.4).timeout

func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		location = file.get_var(location)
		currenthealth = file.get_var(currenthealth)
		currentmana = file.get_var(currentmana)
		battlemaxmana = file.get_var(battlemaxmana)
		maxhealth = file.get_var(maxhealth)
		$"../Character".position = location
		GlobalSignals.emit_signal("battlestats", currenthealth, maxhealth, currentmana, battlemaxmana)

func _location(charpos):
	location = charpos
