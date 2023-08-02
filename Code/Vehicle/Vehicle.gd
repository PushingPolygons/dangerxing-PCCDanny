extends Area3D
class_name Vehicle

@onready var road = $Road
@onready var river = $River


@export var speed: float = 10.0 #m/s
@export var is_safe: bool = false

var bounds: float = 20.0

func _ready():
	if is_safe:
		road.hide()
		river.show()
	else:
		river.hide()
		road.show()

func _process(delta):
	position.x -= speed * delta
#	position += transform.basis.z.normalized() * speed * delta
	
	if position.x < -bounds:
		position.x = bounds
	
	if position.x > bounds:
		position.x = -bounds 
