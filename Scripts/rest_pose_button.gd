extends Button
signal rest
var textbutton : Node
var descript_text = "Rest - Restores 50 Mana and 30 HP."

func _ready():
	textbutton = $"../../../Text"

func _on_button_down() -> void:
	rest.emit()

func _on_focus_entered() -> void:
	textbutton.text = descript_text
