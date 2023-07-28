extends Area3D
class_name Player


@onready var lives_ui = $UI/LivesUI


var main: Main
var speed: float = 10.0 # m/s.
var move_increment: float = 1.5
var current_speed: float = speed
var player_lives: int = 3
var spawning_location: Vector3 = Vector3(0.0, 0.0, -7.7)


func _ready():
	position = spawning_location
	area_entered.connect(OnAreaEntered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Vector2()
	
	# Get input from W, A, S, D keys (move_up, move_down, move_left, move_right)
	if Input.is_action_just_pressed("move_up"):
		TweenPosition(Vector3(0,0, -move_increment))
		direction.y -= 1
		update_speed()
	if Input.is_action_just_pressed("move_down"):
		TweenPosition(Vector3(0, 0, move_increment))
		direction.y += 1
		update_speed()
	if Input.is_action_just_pressed("move_left"):
		TweenPosition(Vector3(-move_increment,0, 0))
		direction.x -= 1
		update_speed()
	if Input.is_action_just_pressed("move_right"):
		TweenPosition(Vector3(move_increment, 0, 0))
		direction.x += 1
		update_speed()
	
	direction = direction.normalized() # Normalize the vector to get consistent speed in all directions
	
	position += Vector3(direction.x, 0, direction.y) * speed * delta

	# Check if there is any input to avoid division by zero
	if direction != Vector2():
		# Calculate the angle between the current forward direction and the desired direction
		var angle = atan2(direction.x, direction.y)
		rotation_degrees.y = rad_to_deg(angle) # Set the Y rotation (heading) in degrees
			
			
func update_speed():
	current_speed += move_increment

func TweenPosition(direction: Vector3):
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(self, "position", position + direction, 0.2)


func OnAreaEntered(other_area: Area3D):
	if other_area is Vehicle:
		kill()
	elif other_area is Roost:
		position = spawning_location

func kill():
	player_lives -= 1
	lives_ui.text = str(player_lives)
	position = spawning_location
	if player_lives <= 0:
		main.menu.show()
		queue_free()
