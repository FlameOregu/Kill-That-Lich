extends Button
var titletext : Node
var textbox : Node
var item_image : Node
var style = StyleBoxTexture.new()
var title = "Crappy Skateboard"
var panel_text = "Crappy old skateboard that has the words \"So Kewl\" written on it. Probably used by some schmucks a long time ago, but it still has some power. "

func _ready():
	titletext = $"../../Title Panel/Title Text"
	item_image = $"../../Item Image"
	textbox = $"../../Text Panel/Text"
	style.texture = preload("res://Assets/crappy skateboard full img.png")

func _on_focus_entered() -> void:
	titletext.text = title
	item_image.add_theme_stylebox_override ("panel", style)
	textbox.text = panel_text

func _on_button_down() -> void:
	$"../../Equip Button".grab_focus()
