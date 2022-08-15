extends Node2D

var opcao = 0
var blinks = 0

export var scene_to_go = ""

func _on_LinkButton_pressed():
	OS.shell_open("https://www.youtube.com/watch?v=s-P0kuHBOAU&list=PLQzIfDE4WrynU2YvLd_flYB2jlVey-VEV&index=24")


func _on_exit_pressed():
	scene_to_go = "res://scenes/options.tscn"
	Transition.fade(scene_to_go)
