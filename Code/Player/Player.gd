extends Area3D
class_name Player

var speed: float
var direction: Vector3


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction: Vector3
	
	if Input.is_action_pressed("move_left"):
		direction = Vector3(-1, 0, 0)
	if Input.is_action_pressed("move_right"):
		direction = Vector3(-1, 0, 0)
	if Input.is_action_pressed("move_up"):
		direction = Vector3(0, 0, -1)
	if Input.is_action_pressed("move_down"):
		direction = Vector3(-1, 0, 1)
		position += direction * speed * delta
	
