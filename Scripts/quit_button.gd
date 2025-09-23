extends Button
var focus : bool

func _on_focus_entered() -> void:
	focus = true

func _on_focus_exited() -> void:
	focus = false

func _input(event: InputEvent) -> void:
	if focus == true and Input.is_action_just_pressed("interact"):
		get_tree().quit()
