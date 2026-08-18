extends Button
var descript_text = "Fireball (50 MP, 1 AP) - Shoot a ball of magical fire using your magical essence to magically deal 125 base magic damage."
var textbutton : Node
var actionpanel : Node
var actionnode : Node
var skillpanel : Node
var combotext : Node
var yesbutton : Node
var character : Node
signal fireball
signal cant

func _ready():
	textbutton = $"../../../Text"
	actionpanel = $"../../.."
	actionnode = $"../../../Action Node"
	skillpanel = $"../.."
	combotext = $"../../../../Fight Layer/Combo Text"
	character = GlobalSignals.character

func _on_focus_entered() -> void:
	textbutton.text = descript_text

func _on_button_down() -> void:
	if (GlobalSignals.character.currentmana - 50) >= 0 and (character.action_points - $Fireball.ap_cost) >= 0:
		character._on_ap_change(1)
		character._on_manachange(50)
		fireball.emit()
	elif (character.action_points - $Fireball.ap_cost) < 0: #not enough Action points
		cant.emit()
		skillpanel.hide()
		textbutton.show()
		textbutton.text = "You do not have enough action points."
		await get_tree().create_timer(1).timeout
		textbutton.hide()
		textbutton.text = ""
		actionnode._on_cancel("magic")
	else: #not enough mana
		cant.emit()
		skillpanel.hide()
		textbutton.show()
		textbutton.text = "You do not have enough mana."
		await get_tree().create_timer(1).timeout
		textbutton.hide()
		textbutton.text = ""
		actionnode._on_cancel("magic")
