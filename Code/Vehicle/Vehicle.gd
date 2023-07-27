extends Area3D
class_name Vehicle

@export var speed: float = 10.0 #m/s

func _process(delta):
	position.x -= speed * delta
	
