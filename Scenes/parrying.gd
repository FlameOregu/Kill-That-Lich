extends Node2D
var parrycd : bool
var parry : bool
var parrytime = 0.4
signal parryoff

func _input(event):
	if Input.is_action_just_pressed("space") and parrycd == false:
		_parry()

func _parry():
	$"..".invincible = true
	$"../parryingtxt".visible = true
	parry = true
	parrycd = true
	await get_tree().create_timer(parrytime).timeout
	parryoff.emit()
	if parrycd == true:
		await get_tree().create_timer(2).timeout
		parrycd = false

func _on_parryoff() -> void:
	parry = false
	$"..".invincible = false
	$"../parryingtxt".visible = false

func _ready() -> void:
	$"../parryingtxt".visible = false
