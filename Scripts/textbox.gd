extends Panel

func _ready():
	self.visible = false
	var viewport_size = get_viewport_rect().size
	var size = self.get_size()
	self.position.x = viewport_size.x / 2 - size.x / 2
	self.position.y = viewport_size.y - size.y - 10
