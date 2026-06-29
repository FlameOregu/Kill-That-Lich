extends Button
var focus : bool

func _ready():
	grab_focus()

func _on_focus_entered() -> void:
	focus = true
	$"../Button Beep".play()

func _input(event: InputEvent) -> void:
	if focus == true and Input.is_action_just_pressed("interact"):
		_start()

func _start():
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")

func _on_focus_exited() -> void:
	focus = false
