extends AudioStreamPlayer2D
var fireball_sfx : AudioStream = preload("res://Assets/SFX/fireball_4.ogg")
var cantdo_sfx : AudioStream = preload("res://Assets/SFX/can't do.ogg")

func _fireball() -> void:
	volume_db = 12.0
	stream = fireball_sfx
	play()

func _cant() -> void:
	volume_db = 0.0
	stream = cantdo_sfx
	play()
