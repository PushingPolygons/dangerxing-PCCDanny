extends Area3D
class_name Player

var speed: float = 10.0 # m/s.

func _ready():
	area_entered.connect(OnAreaEntered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Vector2()
	
	# Get input from W, A, S, D keys (move_up, move_down, move_left, move_right)
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	
	direction = direction.normalized() # Normalize the vector to get consistent speed in all directions
	
	position += Vector3(direction.x, 0, direction.y) * speed * delta

	# Check if there is any input to avoid division by zero
	if direction != Vector2():
		# Calculate the angle between the current forward direction and the desired direction
		var angle = atan2(direction.x, direction.y)
		rotation_degrees.y = rad_to_deg(angle) # Set the Y rotation (heading) in degrees

func OnAreaEntered(other_area: Area3D):
	if other_area is Vehicle:
		kill()
	elif other_area is Roost:
			print("Roosted")

func kill():
	queue_free()
