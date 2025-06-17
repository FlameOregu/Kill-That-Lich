extends TextureProgressBar
@export var battlecharacter: Player

func _ready():
	battlecharacter.healthChanged.connect(update)
	update()

func update():
	value = battlecharacter.currenthealth * 100 / battlecharacter.maxhealth
