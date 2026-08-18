extends AudioStreamPlayer2D
var rest_sfx : AudioStream = preload("res://Assets/SFX/Rest_Sound_2.mp3")
var cantdo_sfx : AudioStream = preload("res://Assets/SFX/can't do.ogg")

func _rest() -> void:
	stream = rest_sfx
	play()

func _cant() -> void:
	stream = cantdo_sfx
	play()
