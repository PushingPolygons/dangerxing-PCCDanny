extends Area3D
class_name Roost

@onready var dummy = $Dummy
var is_occupied: bool = false

func _ready():
	dummy.hide()



func Occupy():
	is_occupied = true
	dummy.show()
