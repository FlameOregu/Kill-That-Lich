extends Button
var focus = false
signal _on_select_fight

func _on_focus_entered():
	focus = true
	
func _on_focus_exited():
	focus = false

func _ready():
	self.grab_focus()

func _process(delta):
	if Input.is_action_just_pressed("interact") == true and focus == true: #checks for input and focus
		_on_select_fight.emit()
		print("fight test")

func _on_cancel():
	self.grab_focus()
