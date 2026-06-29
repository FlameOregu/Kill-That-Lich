extends Button
var focus : bool
var save_path = GlobalSignals.save_path

func _on_focus_entered() -> void:
	focus = true
	$"../Button Beep".play()

func _on_focus_exited() -> void:
	focus = false

func _input(event):
	if Input.is_action_just_pressed("interact") and focus == true:
		GlobalSignals.continued = true
		GlobalSignals.load_data()
		get_tree().change_scene_to_file("res://Scenes/Game.tscn")
