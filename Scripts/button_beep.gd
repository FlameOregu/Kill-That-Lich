extends AudioStreamPlayer2D
var sfx_beep: AudioStream = preload("res://Assets/SFX/beep.mp3")
var sfx_cantdo : AudioStream = preload("res://Assets/SFX/can't do.ogg")
var sfx_cando : AudioStream = preload("res://Assets/SFX/can do.ogg")

func _beep():
	stream = sfx_beep
	play()

func _cantdo():
	stream = sfx_cantdo
	play()

func _cando():
	stream = sfx_cando
	play()
