extends Node
class_name Main

const PLAYER = preload("res://Player/Player.tscn")

@onready var menu = $Menu
@onready var play_button = $Menu/VBoxContainer/PlayButton
@onready var quit_button = $Menu/VBoxContainer/QuitButton


var roosts: Array[Roost] = [$Roosts/Roost1, $Roosts/Roost2, $Roosts/Roost3, $Roosts/Roost4]



func _ready():
	play_button.pressed.connect(OnPlayPressed)
	quit_button.pressed.connect(OnQuitPressed)



func IsGameOver():
	return false


func SpawnPlayer():
	var player = PLAYER.instantiate()
	player.main = self
	add_child(player)
	player.position.z = -7.7


func OnPlayPressed():
	menu.hide()
	SpawnPlayer()


func OnQuitPressed():
	get_tree().quit()
	
