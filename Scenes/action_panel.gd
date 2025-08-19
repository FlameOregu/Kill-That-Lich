extends Panel
var children : Array

func _ready():
	_dohide()

func _on_select_fight() -> void:
	show()
	$Text.text = "Are you sure you want to attack?"
	$Text.show()
	$Yes.show()
	$No.show()

func _dohide():
	hide()
	children = self.find_children("*", "", true, false)
	for i in children:
		i.hide()

func _on_cancel() -> void:
	_dohide()

func _on_select_magic() -> void:
	show()
