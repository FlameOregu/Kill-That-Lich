extends TextureProgressBar
@export var visual_correction_curve : Curve
@export var battlecharacter : Player
@export var manatext : Label

func _on_character_manachanged(currentmana: float, maxmana: float) -> void:
	var true_ratio: float = clamp(currentmana / maxmana, 0.0, 1.0)
	var visual_ratio: float = true_ratio
	if visual_correction_curve:
		visual_ratio = visual_correction_curve.sample(true_ratio)
	value = visual_ratio * max_value
	manatext.text = str("Mana: ", str(int(currentmana)) + "/" + str(int(maxmana)))

func _ready():
	max_value = GlobalSignals.maxmana
	value = GlobalSignals.mana
	manatext.text = str("Mana: ", str(int(value)) + "/" + str(int(max_value)))
