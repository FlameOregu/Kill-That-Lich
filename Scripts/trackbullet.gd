extends Node2D

var target_pos : Vector2
var target: Vector2
var speed: float = 0.6
var duration = 20
var locked_on  = false

func _process(delta):
	self.visible = true
	translate(target_pos * speed * delta)
	if locked_on == false:
		target_pos = (target - global_position) #USE THE GOD DAMN TARGET AND TARGET POS
		self.look_at(target) #use target for looking, target pos for translate
		locked_on = true
	duration -= delta
	if duration < 0:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.name == "hurtbox":
		queue_free()

func _ready():
	GlobalSignals.connect("player_position", Callable(self, "_location"))
	self.visible = false

func _location(location: Vector2):
	target = location
