extends Button
var descript_text = "Fireball (50 MP) - Shoot a ball of magical fire using your magical essence to magically deal magic damage."
var textbutton : Node
var actionpanel : Node
var actionnode : Node
var skillpanel : Node
var combotext : Node
var yesbutton : Node
signal fireball

func _ready():
	textbutton = $"../../../Text"
	actionpanel = $"../../.."
	actionnode = $"../../../Action Node"
	skillpanel = $"../.."
	combotext = $"../../../../Fight Layer/Combo Text"

func _on_focus_entered() -> void:
	textbutton.text = descript_text

func _on_button_down() -> void:
	if (GlobalSignals.character.currentmana - 50) >= 0:
		GlobalSignals.character._on_manachange(50)
		fireball.emit()
	else:
		skillpanel.hide()
		textbutton.show()
		textbutton.text = "You do not have enough mana."
		await get_tree().create_timer(1).timeout
		textbutton.hide()
		textbutton.text = ""
		actionnode._on_cancel("magic")
