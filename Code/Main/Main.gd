extends Node
class_name Main

const PLAYER = preload("res://Player/Player.tscn")

@onready var menu = $Menu
@onready var play_button = $Menu/VBoxContainer/PlayButton
@onready var quit_button = $Menu/VBoxContainer/QuitButton
@onready var roosts: Array[Roost] = [$Roosts/Roost1, $Roosts/Roost2, $Roosts/Roost3, $Roosts/Roost4]
@onready var hi_score_ui = $HiScore/HiScoreUI



var hi_score: int = 0


func _ready():
	play_button.pressed.connect(OnPlayPressed)
	quit_button.pressed.connect(OnQuitPressed)
	UpdateHiScore(25)

func UpdateHiScore(player_score: int):
	hi_score = player_score
	hi_score_ui.text = str(hi_score)


# Are all the Roosts occupied?
func IsGameOver():
	for roost in roosts:
		if not roost.is_occupied:
			return false
	return true


func SpawnPlayer():
	var player = PLAYER.instantiate()
	player.main = self
	add_child(player)
	player.position.z = -6.8


func OnPlayPressed():
	menu.hide()
	SpawnPlayer()


func OnQuitPressed():
	get_tree().quit()
	
