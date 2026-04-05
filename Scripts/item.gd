extends Button
var titletext : Node
var textbox : Node
var item_image : Node
var full_style = StyleBoxTexture.new()
var icon_image = self.icon
var title : String
var panel_text : String

func _ready():
	titletext = $"../../Title Panel/Title Text"
	item_image = $"../../Item Image"
	textbox = $"../../Text Panel/Text"

func _on_focus_entered() -> void:
	titletext.text = title
	item_image.add_theme_stylebox_override ("panel", full_style)
	textbox.text = panel_text

func _on_button_down() -> void:
	$"../../Equip Button".grab_focus()
