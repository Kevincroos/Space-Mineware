extends Node2D

var opcao = 0

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_down"):
		opcao += 1
	
	if Input.is_action_just_pressed("ui_up"):
		opcao -= 1
	
	if opcao < 0:
		opcao = $".".get_child_count() - 1
	
	if opcao == $".".get_child_count() - 4:
		opcao = $".".get_child_count() - 4
		
	if opcao > $".".get_child_count():
		opcao = 0
	
	if opcao > $".".get_child_count() - 2:
		opcao = 0

	$seta/pointer.global_position = $".".get_child(opcao).global_position + Vector2(1, -6)
