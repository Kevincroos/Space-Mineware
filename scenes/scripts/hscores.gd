extends Node2D

var opcao = 0
var blinks = 0

func _ready():
	pass

func _process(delta):

	if Input.is_action_just_pressed("ui_down"):
		opcao += 1

	if Input.is_action_just_pressed("ui_up"):
		opcao -= 1

	if opcao < 0:
		opcao = $itens.get_child_count() - 1

	if opcao > $itens.get_child_count() - 1:
		opcao = 0

	if Input.is_action_just_pressed("ui_accept"):
		match opcao:
			0:
				$blink_timer.start()
			1:
				$blink_timer.start()
			2:
				get_tree().change_scene("res://scenes/hscores.tscn")

	$seta/pointer.global_position = $itens.get_child(opcao).global_position + Vector2(-10, 6.5)


func _on_blink_timer_timeout():
	if opcao == 0:
		blinks += 1
		$itens/start.visible = not $itens/start.visible
		$itens/start/Label.self_modulate = Color.yellowgreen
		if blinks > 10:
			get_tree().change_scene("res://scenes/options.tscn")
