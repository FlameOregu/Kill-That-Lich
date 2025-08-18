extends Panel
var children = self.find_children("*", "", true, false)

func _ready():
	_dohide()

func _on_select_fight() -> void:
	show()
	$Text.text = "Are you sure you want to attack?"
	$Text.show()

func _dohide():
	hide()
	for i in children:
		i.hide()

func _on_cancel() -> void:
	_dohide()
