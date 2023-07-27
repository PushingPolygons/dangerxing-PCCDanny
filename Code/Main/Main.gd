extends Node
class_name Main

const PLAYER = preload("res://Player/Player.tscn")


func StartGame():
	var player = PLAYER.instantiate()
	player.position.z = -7.7
