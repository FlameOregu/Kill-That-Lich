extends Button
signal _on_select_pose
var focus : bool

func _input(event: InputEvent):
	if Input.is_action_just_pressed("interact") == true and focus == true and $"../Fight Layer/Character".infight == false:
		_on_select_pose.emit()

func _on_focus_entered() -> void:
	focus = true

func _on_focus_exited() -> void:
	focus = false
