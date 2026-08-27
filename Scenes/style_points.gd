extends Label

func _on_points_update(style_points) -> void:
	self.text = str(style_points)
