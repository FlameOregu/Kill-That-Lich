extends Button
var focus = false
var soundready : bool
signal _on_select_fight

func _on_focus_entered():
	focus = true
	if soundready == true and $"../Fight Layer/Character".infight == false:
		$"../Button Beep".stream = preload("res://Assets/SFX/beep.mp3")
		$"../Button Beep".play()

func _on_focus_exited():
	focus = false

func _ready():
	soundready = false
	self.grab_focus()
	soundready = true

func _input(event: InputEvent):
	if Input.is_action_just_pressed("interact") == true and focus == true and $"../Fight Layer/Character".infight == false: #checks for input and focus as well as if you are in the fight
		_on_select_fight.emit()

func _on_cancel():
	self.grab_focus()
