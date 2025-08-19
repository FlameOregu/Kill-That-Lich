extends Button
var focus = false
signal _on_select_fight

func _on_focus_entered():
	focus = true
	
func _on_focus_exited():
	focus = false

func _ready():
	self.grab_focus()

func _input(event: InputEvent):
	if Input.is_action_just_pressed("interact") == true and focus == true and $"../Fight Layer/Character".infight == false: #checks for input and focus as well as if you are in the fight
		_on_select_fight.emit()

func _on_cancel():
	self.grab_focus()
