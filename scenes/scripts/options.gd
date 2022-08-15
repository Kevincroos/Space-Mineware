extends Node2D
export var scene_to_go = ""

func _on_creditos_pressed():
	scene_to_go = "res://scenes/creditos.tscn"
	Transition.fade(scene_to_go)

func _on_galeria_pressed():
	scene_to_go = "res://scenes/galeria.tscn"
	Transition.fade(scene_to_go)

func _on_notas_pressed():
	scene_to_go = "res://scenes/notas.tscn"
	Transition.fade(scene_to_go)

func _on_scores_pressed():
	scene_to_go = "res://addons/silent_wolf/Scores/Leaderboard.tscn"
	Transition.fade(scene_to_go)


func _on_exit_pressed():
	scene_to_go = "res://scenes/main-menu.tscn"
	Transition.fade(scene_to_go)

