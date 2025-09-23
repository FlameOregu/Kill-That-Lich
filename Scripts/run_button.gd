extends Button
signal _on_select_run
var focus : bool

func _input(event: InputEvent):
	if Input.is_action_just_pressed("interact") == true and focus == true and $"../Fight Layer/Character".infight == false:
		_on_select_run.emit()

func _on_focus_entered() -> void:
	focus = true
	if $"../Fight Layer/Character".infight == false:
		$"../Button Beep".stream = preload("res://Assets/SFX/beep.mp3")
		$"../Button Beep".play()
func _on_focus_exited() -> void:
	focus = false
