extends CanvasLayer
var children : Array

func _ready():
	children = find_children("*", "", true, true)
	_dohide()

func _dohide():
		hide()
		for i in children:
			if i is Node:
				i.set_process(false)
				i.set_physics_process(false)
				i.set_process_input(false)
				i.set_process_unhandled_input(false)
				i.set_process_unhandled_key_input(false)

func _unhide():
	show()
	for i in children:
		if i is Node:
				i.set_process(true)
				i.set_physics_process(true)
				i.set_process_input(true)
				i.set_process_unhandled_input(true)
				i.set_process_unhandled_key_input(true)

func _on_endfight() -> void:
	_dohide()

func _on_engage() -> void:
	_unhide()
	print("unhidden")

func _on_run() -> void:
	queue_free()
