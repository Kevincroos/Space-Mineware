extends Node2D


func _ready():
	pass

func _process(delta):
	
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://scenes/options.tscn")
	
	if Input.is_action_pressed("ui_up"):
		$seta/pointer.global_position.y -= .5
		$versoes.global_position.y += 1
		$"3cDxl1".global_position.y += 1.5
	if Input.is_action_pressed("ui_down"):
		$seta/pointer.global_position.y += .5
		$versoes.global_position.y-= 1
		$"3cDxl1".global_position.y -= 1.5
	$seta/pointer.global_position.y = clamp($seta/pointer.global_position.y, 95, 270)
	$"3cDxl1".global_position.y = clamp($"3cDxl1".global_position.y, 09, 602)
	$versoes.global_position.y = clamp($versoes.global_position.y, 09, 370)
