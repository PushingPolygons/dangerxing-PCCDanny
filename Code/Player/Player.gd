extends Area3D
class_name Player

var speed: float = 10.0 # m/s.
var direction: Vector3


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	position += Vector3(direction.x, 0, direction.y) * speed * delta
#	position.x += 10 * delta
	print(direction)


#	if Input.is_action_pressed("move_left"):
#		direction = Vector3(-1, 0, 0)
#	if Input.is_action_pressed("move_right"):
#		direction = Vector3(-1, 0, 0)
#	if Input.is_action_pressed("move_up"):
#		direction = Vector3(0, 0, -1)
#	if Input.is_action_pressed("move_down"):
#		direction = Vector3(-1, 0, 1)
#		position += direction * speed * delta
#
