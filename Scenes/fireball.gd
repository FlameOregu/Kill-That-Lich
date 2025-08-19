extends Button
var focus : bool
var magicselect : bool
signal outengage
signal cancel
signal enemyhit(damage : int)

func _ready():
	hide()

func _on_select_magic() -> void:
	show()
	self.grab_focus()
	await get_tree().create_timer(0.2).timeout
	magicselect = true

func _input(event):
	if Input.is_action_just_pressed("interact") and focus == true and magicselect == true:
		if ($"../../Fight Layer/Character".currentmana - 50) >= 0:
			$"../../Fight Layer/Character".currentmana -= 50
			enemyhit.emit(100)
			outengage.emit()
			hide()
			magicselect = false
		else:
			hide()
			$"..".show()
			$"../Text".show()
			$"../Text".text = "You do not have enough mana."
			await get_tree().create_timer(1.5).timeout
			$"..".hide()
			$"../Text".hide()
			$"../Text".text = ""
			cancel.emit()
			magicselect = false
	elif Input.is_action_just_pressed("cancel"):
		cancel.emit()
		magicselect = false
func _on_focus_entered() -> void:
	focus = true

func _on_focus_exited() -> void:
	focus = false
