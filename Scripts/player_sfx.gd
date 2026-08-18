extends AudioStreamPlayer2D
var combo_sfx : AudioStream = preload("res://Assets/SFX/combo 4.mp3")
var parry_sfx : AudioStream = preload("res://Assets/SFX/skateboard parry 3.mp3")
var hurt_sfx : AudioStream = preload("res://Assets/SFX/hit 6.mp3")

func _combo(combo: String) -> void:
	stream = combo_sfx
	play()


func _parry() -> void:
	stream = parry_sfx
	play()

func _hurt() -> void:
	stream = hurt_sfx
	play()
