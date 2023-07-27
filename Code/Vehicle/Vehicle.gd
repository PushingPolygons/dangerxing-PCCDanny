extends Area3D
class_name Vehicle

@export var speed: float = 10.0 #m/s
var bounds: float = 20.0

func _process(delta):
	position.x -= speed * delta
	if position.x < -bounds:
		position.x = bounds
	
	if position.x > bounds:
		position.x = -bounds 
