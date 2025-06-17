extends Node

func _process(_delta):
	if Input.is_action_just_pressed("Fullscreen"):
		if DisplayServer.window_get_mode() != 3:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		elif DisplayServer.window_get_mode() == 3:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
