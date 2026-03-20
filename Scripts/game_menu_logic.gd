extends Node
@export var skillpanel : Control
@export var invpanel : Control
@export var skillstab : Control
@export var invtab : Control
var inmenu = false
signal closemenu

func _showskills():
	skillpanel.show()
	invpanel.hide()
	skillstab.size = Vector2(144,26)
	skillstab.position = Vector2(21, 4)
	invtab.size = Vector2(144,18)
	invtab.position = Vector2(165, 12)

func _showinv():
	invpanel.show()
	skillpanel.hide()
	invtab.size = Vector2(144,26)
	invtab.position = Vector2(165, 4)
	skillstab.size = Vector2(144,18)
	skillstab.position = Vector2(21, 12)

func _openmenu():
	_showskills()
	inmenu = true

func _input(event):
	if inmenu == true:
		if Input.is_action_just_pressed("menu"):
			if skillpanel.visible:
				_showinv() #shows inventory tab
				$"../Inventory Panel/Inventory Container".get_child(0).grab_focus()
			elif invpanel.visible:
				_showskills() #shows skill tab
				$"../Inventory Panel/Inventory Container".get_child(0).release_focus()
		elif Input.is_action_just_pressed("cancel"):
			inmenu = false
			closemenu.emit()
