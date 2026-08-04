extends Button
signal rest
var textbutton : Node
var character : Node
var actionpanel : Node
var actionnode : Node
var skillpanel : Node
var combotext : Node
var descript_text = "Rest (1 AP) - Restores 50 Mana and 30 HP."

func _ready():
	textbutton = $"../../../Text"
	actionpanel = $"../../.."
	actionnode = $"../../../Action Node"
	skillpanel = $"../.."
	combotext = $"../../../../Fight Layer/Combo Text"
	character = GlobalSignals.character

func _on_button_down() -> void:
	if character.action_points - $"Rest Pose".ap_cost >= 0:
		character._on_ap_change(1)
		$SFX.play()
		rest.emit()
	else:
		skillpanel.hide()
		textbutton.show()
		textbutton.text = "You do not have enough action points."
		await get_tree().create_timer(1).timeout
		textbutton.hide()
		textbutton.text = ""
		actionnode._on_cancel("pose")

func _on_focus_entered() -> void:
	textbutton.text = descript_text
