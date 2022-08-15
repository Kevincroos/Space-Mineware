extends Node2D

export(NodePath) var nave
var time = 0.0

func _ready():
	
	if nave:
		nave = get_node(nave)
	else:
		set_process(false)
	
func _process(delta):
	global_position.x = (nave.global_position.x - 80) * 0.003 * -160
