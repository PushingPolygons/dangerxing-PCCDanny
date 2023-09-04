extends Area3D
class_name Player


@onready var lives_ui = $UI/VBoxContainer/LivesUI
@onready var score_ui = $UI/VBoxContainer/ScoreUI



var main: Main
var speed: float = 180.0 # m/s.
var move_increment: float = 1.5
var current_speed: float = speed
var player_lives: int = 3
var spawning_location: Vector3 = Vector3(0.0, 0.0, -7.7)
var score: int = 0
var ride_along: Vehicle = null
var ride_offset: float = 0 # X axis.


func _ready():
	position = spawning_location
	area_entered.connect(OnAreaEntered)
	area_exited.connect(OnAreaExited)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if ride_along:
		global_position = ride_along.global_position
	var direction = Vector2()
	
	# Get input from W, A, S, D keys (move_up, move_down, move_left, move_right)
	if Input.is_action_just_pressed("move_up"):
		if ride_along:
			ride_along = null
		direction.y -= 1
		update_speed()
		
	if Input.is_action_just_pressed("move_down"):
		if ride_along:
			ride_along = null
		direction.y += 1
		update_speed()

			
	if Input.is_action_just_pressed("move_left"):
		if not ride_along:
			direction.x -= 1
			update_speed()
		
	if Input.is_action_just_pressed("move_right"):
		if not ride_along:
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
 
#func TweenPosition(direction: Vector3):
#	var tween = create_tween()
#	tween.set_ease(Tween.EASE_OUT)
#	tween.set_trans(Tween.TRANS_BOUNCE)
#	tween.tween_property(self, "position", position + direction, 0.2)

func UpdateScore(delta_score: int):
	score += delta_score
	score_ui.text = "Score: " + str(score)
	
	if score > main.hi_score:
		main.UpdateHiScore(score)
	

func OnAreaEntered(other_area: Area3D):
	if other_area is Vehicle:
		if other_area.is_safe:
			# Ride Along.
#			reparent(other_area)
			ride_along = other_area
		else:
			ride_along = null
			kill()
	elif other_area is Roost:
		position = spawning_location # Jump back to spawn.
		other_area.Occupy()
		if main.IsGameOver():
			get_tree().reload_current_scene()
#			main.menu.show()
	elif other_area is River:
		kill()

func OnAreaExited(other_area: Area3D):
	pass
#	ride_along = null


func kill():
	player_lives -= 1
	lives_ui.text = "Lives: " + str(player_lives)
	position = spawning_location
	if player_lives <= 0:
		main.menu.show()
		queue_free()


#k func update_player_lives
