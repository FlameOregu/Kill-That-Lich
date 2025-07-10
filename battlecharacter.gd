extends CharacterBody2D
class_name Player
@export var speed = 200
var direction:Vector2
var maxhealth = 100.0
var currenthealth: float = maxhealth

signal on_character_moving(is_moving:bool)
signal healthChanged
func _process(_delta):
	direction = Input.get_vector("left","right","up","down") 
	if !direction.is_zero_approx():
		on_character_moving.emit(true)
	elif direction.is_zero_approx():
		on_character_moving.emit(false)

func _physics_process(_delta):
	velocity = direction * speed
	move_and_slide()
	
#func _ready():
#	set_process(false)


func _on_hurtbox_area_entered(area):
	if area.name == "Bullet":
		currenthealth -= 50
		healthChanged.emit()
		
