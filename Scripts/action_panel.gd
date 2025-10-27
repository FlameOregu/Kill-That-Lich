extends Panel
var children : Array
var pos = Vector2(14,11)
var actions : Array

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
	for i in actions:
		i.queue_free()
		actions.erase(i)
	pos = Vector2(14,11)
	_dohide()

func _on_select_magic() -> void:
	for i in GlobalSignals.magics:
		var scene = load(i).instantiate()
		add_child(scene)
		actions.append(scene)
		scene.position = pos
		if pos == Vector2(656, 11):
			pos = Vector2(14, 60)
		else:
			pos += Vector2(214, 0)
	show()

func _on_select_pose() -> void:
	show()

func _on_select_run() -> void:
	show()
	$Text.text = "Are you sure you want to run?"
	$Text.show()
	$Yes.show()
	$No.show()
